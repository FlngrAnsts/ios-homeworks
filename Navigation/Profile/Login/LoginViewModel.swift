//
//  LoginVM.swift
//  Navigation
//
//  Created by Anastasiya on 14.06.2024.
//

import Foundation


protocol LogInModelProtocol{
    var isLogIn: Bool {get set}
    
    func userButtonPressed(loginVM: String, passwordVM: String) -> User
}



final class LoginViewModel: LogInModelProtocol {
    
    var isLogIn = false
    
    var loginDelegate: LoginViewControllerDelegate?
    
    
    
    func userButtonPressed(loginVM: String, passwordVM: String) -> User {
        
        var userForProfile: UserService
#if DEBUG
        userForProfile = TestUserService(user: users[0])
#else
        userForProfile = CurrentUserService(user: users[1])
#endif
        
        return userForProfile.user
    }
}
