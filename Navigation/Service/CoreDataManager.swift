//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Anastasiya on 23.12.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer
        
        private init() {
            persistentContainer = NSPersistentContainer(name: "Navigation")
            persistentContainer.loadPersistentStores { _, error in
                if let error = error {
                    fatalError("Failed to load Core Data stack: \(error)")
                }
            }
        }

    func saveContext() {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print("Error saving context: \(error)")
                }
            }
        }
    
    func fetchUser(email: String, password: String) -> Result<UserData, ApiError> {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<UserData> = UserData.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        request.fetchLimit = 1
        do {
            if let user = try context.fetch(request).first {
                return .success(user)
            } else {
                return .failure(.userNotFoundAndWrongPassword)
            }
        } catch {
            return .failure(.authError(message: "Unexpected error: \(error.localizedDescription)"))
        }
    }

    
    
    func createUser(email: String,firstName:String, lastName: String, password: String, avatar: Data/*, status: String*/) -> Result<UserData, ApiError> {
            guard password.count >= 6 else {
                return .failure(.weakPass)
            }
            
            let context = persistentContainer.viewContext
            let request: NSFetchRequest<UserData> = UserData.fetchRequest()
            request.predicate = NSPredicate(format: "email == %@", email)
            
            do {
                if try context.fetch(request).isEmpty {
                    let newUser = UserData(context: context)
                    newUser.id = UUID()
                    newUser.email = email
                    newUser.firstName = firstName
                    newUser.lastName = lastName
                    newUser.fullName = firstName + " " + lastName
                    newUser.password = password
                    newUser.avatar = avatar
                    newUser.status = "Welcome"
                    newUser.isAuthorized = false
                    
                    try context.save()
                    return .success(newUser)
                } else {
                    return .failure(.suchUserAlreadyExists)
                }
            } catch {
                return .failure(.authError(message: "Unexpected error: \(error.localizedDescription)"))
            }
        }
    
//    func registerUser(email: String, fullName: String, password: String, completion: @escaping (Result<String, ApiError>) -> Void) {
//        //
//        let context = CoreDataManager.shared.context
//        //
//        // Проверка уникальности email
//        let emailFetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
//        emailFetchRequest.predicate = NSPredicate(format: "email == %@", email)
//        
//        do {
//            let emailResults = try context.fetch(emailFetchRequest)
//            if !emailResults.isEmpty {
//                completion(.failure(.suchUserAlreadyExists)) //мыло занято
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
//            newUser.id = UUID()
//            newUser.email = email
//            newUser.fullName = fullName
//            newUser.password = password
//            newUser.avatar = nil
//            newUser.status = ""
//            
//            // Сохраняем данные
//            //            CoreDataManager.shared.
//            saveContext()
//            completion(.success(newUser.email ?? "")) // Возвращаем email зарегистрированного пользователя
//        } catch {
//            completion(.failure(.authError(message: "Ошибка регистрации: \(error.localizedDescription)")))
//        }
//        
//    }
    
//    public func createProfile(with phoneNumber: String) {
//        let profile = UserData(context: context)
//        profile.id = UUID()
//        profile.phone = phoneNumber
//        profile.dayBirth = "unknown"
//        profile.name = "unknown"
//        profile.surname = "unknown"
//        profile.userAvatar = "unknown"
//        profile.hometown = "unknown"
//        profile.userJob = "unknown"
//        profile.photos = []
//        profile.posts = []
//        profile.favoritesPosts = []
//        profile.followers = []
//        profile.subscriptions = []
//        saveContext()
//    }
    
//    public func getUser() {
//        guard let profileEmail = CurrentProfileService.shared.featchCurrentProfile() else {return}
//        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
//         fetchRequest.predicate = NSPredicate(format: "email == %@", profileEmail)
//        do {
//            guard let result = try context.fetch(fetchRequest).first else {return}
//            CurrentProfileService.shared.currentProfile = result
//        } catch let error {
//            print("ERROR: \(error)")
//        }
//    }
//    
//    public func createPost(image: String?, text: String?) -> PostData {
//        let post = PostData(context: context)
////        post.id = UUID()
////        post.image = image
////        post.descriptions = text
////        saveContext()
//        return post
//    }
//    
//    public func deletePost(post: PostData) {
//        persistentContainer.viewContext.delete(post)
//        saveContext()
//    }
    
    
    
}

extension CoreDataManager {
    func fetchAllUsers() -> [UserData] {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<UserData> = UserData.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching all users: \(error)")
            return []
        }
    }
    
    func fetchAuthorizedUser() -> UserData? {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<UserData> = UserData.fetchRequest()
        request.predicate = NSPredicate(format: "isAuthorized == %@", NSNumber(value: true))
        request.fetchLimit = 1
        
        do {
            return try context.fetch(request).first
        } catch {
            print("Error fetching authorized user: \(error)")
            return nil
        }
    }
    
    func authorizeUser(user: UserData) {
        let context = persistentContainer.viewContext
        user.isAuthorized = true
        
        do {
            try context.save()
        } catch {
            print("Error authorizing user: \(error)")
        }
    }
    
    // Метод для выхода (сброс флага авторизации)
    func logoutUser(user: UserData) {
        let context = persistentContainer.viewContext
        user.isAuthorized = false
        
        do {
            try context.save()
        } catch {
            print("Error authorizing user: \(error)")
        }
        
    }
}

extension UserData {
    
//    func changeSubscribeState(for profile: UserData) {
//        profile.isFollower(profile: self) == true ? unsubscribeTo(profile: profile) : subscribeTo(profile: profile)
//    }
//    
//    private func subscribeTo(profile: UserData) {
//        self.addToSubscriptions(profile)
//        profile.addToFollowers(self)
//        try? managedObjectContext?.save()
//    }
//    
//    private func unsubscribeTo(profile: UserData) {
//        self.removeFromSubscriptions(profile)
//        profile.removeFromFollowers(self)
//        try? managedObjectContext?.save()
//    }
//    
//    func isFollower(profile: UserData) -> Bool? {
//        self.followers?.contains(profile)
//    }
//    
//    func isSubscriber(profile: UserData) -> Bool? {
//        self.subscriptions?.contains(profile)
//    }
    
//    func changeFavoritePostState(for post: PostData) {
//        self.isFavoritePost(post: post) == true ? unfavoritePostTo(post: post) : favoritePostTo(post: post)
//    }
    
//    func isFavoritePost(post: PostData) -> Bool? {
//        self.favoritesPosts?.contains(post)
//    }
//    
//    private func favoritePostTo(post: PostData) {
//        self.addToFavoritesPosts(post)
//        try? managedObjectContext?.save()
//    }
//    
//    private func unfavoritePostTo(post: PostData) {
//        self.removeFromFavoritesPosts(post)
//        try? managedObjectContext?.save()
//    }
    
}
