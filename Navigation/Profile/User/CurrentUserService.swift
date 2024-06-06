//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Anastasiya on 06.06.2024.
//

import UIKit

class CurrentUserService: UserService {
    
    var user = User(
        login: "Grivus",
        fullName: "General Grivus",
        avatar: UIImage(named: "grivus")!,
        status: "Уничтожить их! Но сперва помучить!"
    )
    
    init(user: User = User(
        login: "Grivus",
        fullName: "General Grivus",
        avatar: UIImage(named: "grivus")!,
        status: "Уничтожить их! Но сперва помучить!"
    )) {
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
