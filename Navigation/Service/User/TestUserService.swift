//
//  TestUserService.swift
//  Navigation
//
//  Created by Anastasiya on 06.06.2024.
//

import UIKit

class TestUserService: UserService {

    var user = User(
        login: "Grivus",
        fullName: "General Grivus",
       password: "a123",
        avatar: UIImage(named: "grivus")!,
        status: "Уничтожить их! Но сперва помучить!"
    )
    
    
    
//    func authorizationkUser(login: String) -> User? {
//        if user.login == login {
//            return user
//        }else {
//            return nil
//        }
//    }
}
