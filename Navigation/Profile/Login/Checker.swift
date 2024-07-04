//
//  Checker.swift
//  Navigation
//
//  Created by Anastasiya on 10.06.2024.
//

import UIKit

class Checker {
    static let shared: Checker = {
        let instance = Checker()
            return instance
        }()
    
    private let userLogin : String
       
    private let userPassword : String
       
    var userProfile: UserService
    private init() {
#if DEBUG
        userProfile = TestUserService(user: users[0])
#else
        userProfile = CurrentUserService(user: users[1])
#endif
        userLogin = userProfile.user.login
        userPassword = userProfile.user.password
        
    }
       
    func check(login: String, password: String)-> Bool{
           login ==  userLogin && password == userPassword
       }
    
    func checkLogin(login: String)->Bool{
        login == userLogin
    }
    
    func checkPassword(password: String)->Bool{
        password == userPassword
    }
    
   }



   extension Checker: NSCopying {
       func copy(with zone: NSZone? = nil) -> Any {
           return self
       }
   }
