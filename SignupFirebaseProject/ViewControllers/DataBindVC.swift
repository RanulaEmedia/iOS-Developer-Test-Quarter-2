//
//  DataBindVC.swift
//  SignupFirebaseProject
//
//  Created by Ranula Ranatunga on 6/26/20.
//  Copyright © 2020 Ranula Ranatunga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseDatabase

class DataBindVC: UIViewController , UIScrollViewDelegate {
    
    let bag = DisposeBag()
    
    var userList = BehaviorRelay<[User]>(value: [])
    var firstName = BehaviorRelay<String>(value: "")
    var lastName = BehaviorRelay<String>(value: "")
    var email = BehaviorRelay<String>(value: "")

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ButtonAdd: UIBarButtonItem!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var fNameTxt: UITextField!
    @IBOutlet weak var lNameTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addObservers()
        
    }
    
    func setupUI() {
        title = "DataBind"
        tableView.tableFooterView = UIView()
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        tableView.register(UINib(nibName: "UserTVCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
    
    func addObservers() {
        
        ButtonAdd.rx.tap
            .subscribe() {[weak self] event in
                self?.addNewUserToList()
        }
        .disposed(by: bag)
        
        
        fNameTxt.rx.text
            .orEmpty
            .bind(to: firstName)
            .disposed(by: bag)
        
        lNameTxt.rx.text
            .orEmpty
            .bind(to: lastName)
            .disposed(by: bag)
    }
    
    func bindData(){
           
       }
    
     func addNewUserToList() {
           
           let _user = User(_id: nil, uuid: nil, firstName: self.firstName.value, lastName: self.lastName.value, fullName: nil, email: self.email.value)
           let ref = Database.database().reference(withPath: "users").childByAutoId()
           let newUserId = ref.key ?? NSUUID().uuidString
           let userInfoDictionary = ["id" :newUserId,
                                     "firstname" : self.firstName.value,
                                     "lastname" : self.lastName.value,
                                     "email" : self.email.value]
           
           
           ref.setValue(userInfoDictionary) {
               (error:Error?, ref:DatabaseReference) in
               if let error = error {
                   print(error.localizedDescription)
               } else {
                var currentUsers: [User] = self.userList.value
                   currentUsers.append(_user)
                self.userList.accept(currentUsers)
               }
           }
       }
    
       }
    

