//
//  CheckerService.swift
//  Navigation
//
//  Created by Anastasiya on 01.07.2024.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol{
    
    func checkCredentials(withEmail: String, password: String ,completion: @escaping (Result<String, ApiError>) -> Void)
    
    func signUp(withEmail: String, password: String ,completion: @escaping (Result<String, ApiError>) -> Void)
    
}

class CheckerService: CheckerServiceProtocol{
    
    func checkCredentials(withEmail: String, password: String, completion: @escaping (Result<String, ApiError>) -> Void) {
        Auth.auth().signIn(withEmail: withEmail, password:password){ authResult, error in
            
            if let error {
                let err = error as NSError
                switch err.code{
                case AuthErrorCode.invalidCredential.rawValue:
                    completion(.failure(ApiError.userNotFound))
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.failure(ApiError.userNotFoundAndWrongPassword))
                case AuthErrorCode.wrongPassword.rawValue:
                    completion(.failure(ApiError.userNotFoundAndWrongPassword))
                default:
                    completion(.failure(ApiError.authError(message: "Unknown error")))
                }
            }
            if let authResult{
                completion(.success(authResult.user.displayName ?? ""))
            }
            
        }
        
    }
    
    
    func signUp(withEmail: String, password: String, completion: @escaping (Result<String, ApiError>) -> Void) {
        
        FirebaseAuth.Auth.auth().createUser(withEmail: withEmail, password: password){ authResult, error  in
            if let error {
                let err = error as NSError
                switch err.code{
                case AuthErrorCode.invalidEmail.rawValue:
                    completion(.failure(ApiError.incorrectEmail))
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(.failure(ApiError.suchUserAlreadyExists))
                case AuthErrorCode.weakPassword.rawValue:
                    completion(.failure(ApiError.weakPass))
                default:
                    completion(.failure(ApiError.authError(message: "Unknown error")))
                }
            }
            if let authResult{
                completion(.success(authResult.user.displayName ?? ""))
            }
        }
    }
    
}
