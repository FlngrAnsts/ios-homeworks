//
//  TestUserService.swift
//  Navigation
//
//  Created by Anastasiya on 06.06.2024.
//

import UIKit

class TestUserService: UserService {
    
    var user = User(login: "CT-7567",
                    fullName: "Capitan Rex",
                    avatar: UIImage(named: "Rex")!,
                    status: "Меня зовут Рекс. Но для вас я - Капитан"
    )
    
    init(user: User = User(login: "CT-7567",
                           fullName: "Capitan Rex",
                           avatar: UIImage(named: "Rex")!,
                           status: "Меня зовут Рекс. Но для вас я - Капитан"
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
