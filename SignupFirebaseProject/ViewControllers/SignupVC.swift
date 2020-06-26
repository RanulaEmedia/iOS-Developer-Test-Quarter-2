//
//  SignupVC.swift
//  SignupFirebaseProject
//
//  Created by Ranula Ranatunga on 6/25/20.
//  Copyright © 2020 Ranula Ranatunga. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import RxCocoa
import RxSwift


class SignupVC: UIViewController {

    @IBOutlet weak var firstNameTxtF: UITextField!
    @IBOutlet weak var LastNameTxtF: UITextField!
    @IBOutlet weak var emailTxtF: UITextField!
    @IBOutlet weak var passwordTxtF: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    
    var firstName = BehaviorRelay<String>(value: "")
    var lastName = BehaviorRelay<String>(value: "")
    var phone = BehaviorRelay<String>(value: "")
    var email = BehaviorRelay<String>(value: "")
    
     // set the reference from real time database
    let referen  = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        let db = Firestore.firestore()
    }
    
    // function called as setup element with element through view did loader
    func setUpElements()
    {
        errorLbl.alpha = 0
        // change the elment color with utilities function
        Utilities.styleTextField(firstNameTxtF)
        Utilities.styleTextField(LastNameTxtF)
        Utilities.styleTextField(emailTxtF)
        Utilities.styleTextField(passwordTxtF)
    }
    
    func validatingFields() -> String?
    {
        if
            firstNameTxtF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastNameTxtF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTxtF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTxtF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
                  return "fill all fields"
        }
        
        // check if the password is secure
        
        let cleanedPassword = passwordTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == true {
            //password isn't secure enough
            return "please make sure your password is at least 8 characters , contains a special character and a number"
        }
        return nil
      
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        //validating fields
        let error = validatingFields()
        
        if error != nil {
            
            // there's something wrong with the fields , show errror message
            showError(error!)
        }
        else
        
        {   // Create cleaned version of the data
            let firstName = firstNameTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNameTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        //creating the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //checking errors
                if let err = err {
                    // there was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    // user was created succssfully , now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName ,"uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            //show error message
                            self.showError("Error saving user data")
                        }
                    }
                }
            }
        
         // Transition to the home screen
            self.transitionToHome()
        }
    }
    
    
    @IBAction func didTapUpdateBtn(_ sender: Any)
    {
        guard let firstName = firstNameTxtF.text else {return}
        guard let lastName = LastNameTxtF.text else {return}
        guard let email = emailTxtF.text else {return}
        guard let password = passwordTxtF.text else {return}
         
        
        //referen.childByAutoId("DBz2HzArQ80XzroAxUSR").update
        referen.child("users").updateChildValues(["firstName": firstName,"lastName": lastName ,"email":email , "password": password])
    }
    

   func AlertProvider() {
        let alert = UIAlertController(title: "Signed Up", message: "You have successfully signed up!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
    }
    
    func showError(_ message:String)
    {
        errorLbl.text = message
        errorLbl.alpha = 1
    }
    
    func transitionToHome()
    {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as?
        HomeVC
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}

