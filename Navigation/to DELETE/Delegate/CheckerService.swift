//
//  CheckerService.swift
//  Navigation
//
//  Created by Anastasiya on 01.07.2024.
//

import Foundation
import CoreData
//import FirebaseAuth
import UIKit

//protocol CheckerServiceProtocol{
//    
//    func checkCredentials(withIdentifier identifier: String, password: String ,completion: @escaping (Result<String, ApiError>) -> Void)
//    
//    func signUp(withEmail: String, login: String, fullName: String, password: String ,completion: @escaping (Result<String, ApiError>) -> Void)
//    
//}
//
//class CheckerService: CheckerServiceProtocol{
//    
//    func signUp(withEmail: String, login: String, fullName: String, password: String ,completion: @escaping (Result<String, ApiError>) -> Void) {
//        
//        let context = CoreDataManager.shared.context
//
//        // Проверка, существует ли пользователь с таким email
//        let emailFetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
//        emailFetchRequest.predicate = NSPredicate(format: "email == %@", withEmail)
//
//        // Проверка, существует ли пользователь с таким логином
//        let loginFetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
//        loginFetchRequest.predicate = NSPredicate(format: "login == %@", login)
//
//        do {
//            let emailResults = try context.fetch(emailFetchRequest)
//            if !emailResults.isEmpty {
//                completion(.failure(.suchUserAlreadyExists))
//                return
//            }
//
//            let loginResults = try context.fetch(loginFetchRequest)
//            if !loginResults.isEmpty {
//                completion(.failure(.suchUserAlreadyExists))
//                return
//            }
//
//            // Проверка на слабый пароль
//            if password.count < 6 {
//                completion(.failure(.weakPass))
//                return
//            }
//
//            // Создаем нового пользователя
//            let newUser = UserData(context: context)
//            newUser.id = UUID()// Генерация уникального UUID
//            newUser.email = withEmail
////            newUser.login = login
//            newUser.fullName = fullName
//            newUser.password = password
//            newUser.avatar = nil // Пока без аватара
//            newUser.status = ""
//
//            // Сохраняем нового пользователя
//            CoreDataManager.shared.saveContext()
//
//            completion(.success(fullName)) // Возвращаем имя зарегистрированного пользователя
//        } catch {
//            completion(.failure(.authError(message: "Ошибка регистрации: \(error.localizedDescription)")))
//        }
//    }
//    
//
//    func checkCredentials(withIdentifier identifier: String, password: String, completion: @escaping (Result<String, ApiError>) -> Void) {
//        
//        let context = CoreDataManager.shared.context
//
//            // Запрос для поиска пользователя по email или логину
//            let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "(email == %@ OR login == %@) AND password == %@", identifier, identifier, password)
//
//            do {
//                let results = try context.fetch(fetchRequest)
//
//                if let userEntity = results.first {
//                    // Успешная аутентификация, возвращаем имя пользователя
//                    let displayName = userEntity.fullName ??  ""
//                    completion(.success(displayName))
//                } else {
//                    // Если пользователь не найден
//                    completion(.failure(ApiError.userNotFoundAndWrongPassword))
//                }
//            } catch {
//                // Обработка ошибок Core Data
//                completion(.failure(ApiError.authError(message: "Ошибка при проверке учетных данных: \(error.localizedDescription)")))
//            }
//        
////        Auth.auth().signIn(withEmail: withEmail, password:password){ authResult, error in
////            
////            if let error {
////                let err = error as NSError
////                switch err.code{
////                case AuthErrorCode.invalidCredential.rawValue:
////                    completion(.failure(ApiError.userNotFound))
////                case AuthErrorCode.invalidEmail.rawValue:
////                    completion(.failure(ApiError.userNotFoundAndWrongPassword))
////                case AuthErrorCode.wrongPassword.rawValue:
////                    completion(.failure(ApiError.userNotFoundAndWrongPassword))
////                default:
////                    completion(.failure(ApiError.authError(message: "Unknown error")))
////                }
////            }
////            if let authResult{
////                completion(.success(authResult.user.displayName ?? ""))
////            }
////            
////        }
//        
//    }
//    
//
//    
////    func signUp(withEmail: String, password: String, completion: @escaping (Result<String, ApiError>) -> Void) {
////        
////        FirebaseAuth.Auth.auth().createUser(withEmail: withEmail, password: password){ authResult, error  in
////            if let error {
////                let err = error as NSError
////                switch err.code{
////                case AuthErrorCode.invalidEmail.rawValue:
////                    completion(.failure(ApiError.incorrectEmail))
////                case AuthErrorCode.emailAlreadyInUse.rawValue:
////                    completion(.failure(ApiError.suchUserAlreadyExists))
////                case AuthErrorCode.weakPassword.rawValue:
////                    completion(.failure(ApiError.weakPass))
////                default:
////                    completion(.failure(ApiError.authError(message: "Unknown error")))
////                }
////            }
////            if let authResult{
////                completion(.success(authResult.user.displayName ?? ""))
////            }
////        }
////    }
//    
//}
