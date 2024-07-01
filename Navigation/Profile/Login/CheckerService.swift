//
//  CheckerService.swift
//  Navigation
//
//  Created by Anastasiya on 01.07.2024.
//

import Foundation

protocol CheckerServiceProtocol{
    
    func checker(login: String, password: String ,completion: @escaping (Result<String, LogInError>) -> Void)
    
}

class CheckerService: CheckerServiceProtocol{
    func checker(login: String, password: String, completion: @escaping (Result<String, LogInError>) -> Void) {
       
        let isCorrectLogin = Checker.shared.checkLogin(login: login)
        let isCorrectPassword = Checker.shared.checkPassword(password: password)
        if !isCorrectLogin {
            completion(.failure(LogInError.userNotFound))
        }else{
            if isCorrectLogin && !isCorrectPassword{
                completion(.failure(LogInError.incorrectPassord))
            }else{
                completion(.success(login))
//                return Checker.shared.check(login: login, password: password)
            }
        }
    }
    

    
    
}
