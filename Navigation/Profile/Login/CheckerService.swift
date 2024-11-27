//
//  CheckerService.swift
//  Navigation
//
//  Created by Anastasiya on 01.07.2024.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol{
    
    func checkCredentials(withEmail: String, password: String ,completion: @escaping (Result<String, LogInError>) -> Void)
    
    func signUp(withEmail: String, password: String ,completion: @escaping (Result<String, LogInError>) -> Void)
    
}

class CheckerService: CheckerServiceProtocol{
    
    func checkCredentials(withEmail: String, password: String, completion: @escaping (Result<String, LogInError>) -> Void) {
        Auth.auth().signIn(withEmail: withEmail, password:password){ authResult, error in
            
            if let error {
                let err = error as NSError
                switch err.code{
                case AuthErrorCode.invalidCredential.rawValue:
                    completion(.failure(LogInError.userNotFound))
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.failure(LogInError.userNotFoundAndWrongPassword))
                case AuthErrorCode.wrongPassword.rawValue:
                    completion(.failure(LogInError.userNotFoundAndWrongPassword))
                default:
                    completion(.failure(LogInError.authError(message: "Unknown error")))
                }
            }
            if let authResult{
                completion(.success(authResult.user.displayName ?? ""))
            }
            
        }
        
    }
    
    
    
    func signUp(withEmail: String, password: String, completion: @escaping (Result<String, LogInError>) -> Void) {
        
        FirebaseAuth.Auth.auth().createUser(withEmail: withEmail, password: password){ authResult, error  in
            if let error {
                let err = error as NSError
                switch err.code{
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.failure(LogInError.incorrectEmail))
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(.failure(LogInError.suchUserAlreadyExists))
                case AuthErrorCode.weakPassword.rawValue:
                    completion(.failure(LogInError.weakPass))
                default:
                    completion(.failure(LogInError.authError(message: "Unknown error")))
                }
            }
            if let authResult{
                completion(.success(authResult.user.displayName ?? ""))
            }
        }
    }
    
}
