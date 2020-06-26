//
//  ViewController.swift
//  SignupFirebaseProject
//
//  Created by Ranula Ranatunga on 6/25/20.
//  Copyright © 2020 Ranula Ranatunga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElement()
    }


    func setUpElement()
    {
       Utilities.styleFilledButton(signUpBtn)
        Utilities.styleHolllowButton(loginBtn)
    }
}

