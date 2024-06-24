//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Anastasiya on 06.06.2024.
//

import UIKit

class CurrentUserService: UserService {
    
    var user : User
    
    init (user : User) {
        self.user = user
    }
    
    func authorizationkUser(login: String) -> User? {
        if user.login == login {
            return user
        }else {
            return nil
        }
    }
}
