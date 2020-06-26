//
//  LoginVC.swift
//  SignupFirebaseProject
//
//  Created by Ranula Ranatunga on 6/25/20.
//  Copyright © 2020 Ranula Ranatunga. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxtF: UITextField!
    @IBOutlet weak var passwordTxtF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setUpElements(){
        
        // Hide the error label;
        errorLbl.alpha = 0
        
        //Style the elements
        Utilities.styleTextField(emailTxtF)
        Utilities.styleTextField(passwordTxtF)
        Utilities.styleFilledButton(loginBtn)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // validate text field
        
        //create cleaned version of the text field
        let email = emailTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //signing in the user
        Auth.auth().signIn(withEmail: email, password: password)
        { (result ,error) in
            
            if error != nil {
                
                //Couldn't siugn in
                self.errorLbl.text = error!.localizedDescription
                self.errorLbl.alpha = 1
            }
            else {
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as?
               HomeVC
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                
            }
     
        }
    
    }
}
