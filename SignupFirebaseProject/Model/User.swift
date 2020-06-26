//
//  User.swift
//  FirebaseAuthExample
//
//  Created by Pasan Induwara Edirisooriya on 6/24/20.
//  Copyright © 2020 ElegantMedia. All rights reserved.
//

import Foundation

public struct User: Codable {

    public var _id: String?
    public var uuid: String?
    public var firstName: String?
    public var lastName: String?
    public var fullName: String?
    public var email: String?
    

    public init(_id: String?, uuid: String?, firstName: String?, lastName: String?, fullName: String?, email: String?) {
        self._id = _id
        self.uuid = uuid
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.email = email
    }

    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case uuid
        case firstName = "first_name"
        case lastName = "last_name"
        case fullName = "full_name"
        case email
        
    }


}
