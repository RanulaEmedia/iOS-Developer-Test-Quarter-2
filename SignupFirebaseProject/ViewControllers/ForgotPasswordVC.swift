//
//  ForgotPasswordVC.swift
//  SignupFirebaseProject
//
//  Created by Ranula Ranatunga on 6/25/20.
//  Copyright © 2020 Ranula Ranatunga. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var emailTxtF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func didTapResetBtn(_ sender: Any) {
        
        guard let email = emailTxtF.text else {return }
        
        Auth.auth().sendPasswordReset(withEmail: email)
        {
            (error) in
            
            if error == nil {
                print("resset link sent")
            }
        }
    }
    
}
