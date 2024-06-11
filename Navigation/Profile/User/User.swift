//
//  User.swift
//  Navigation
//
//  Created by Anastasiya on 01.06.2024.
//

import UIKit

public class User {
    
    var login: String = ""
    var fullName: String = ""
    var password: String
    var avatar: UIImage
    var status: String
    
    init(login: String, fullName: String, password: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.password = password
        self.avatar = avatar
        self.status = status
    }
    
}


