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
    
    func createUser(email: String,firstName:String, lastName: String, password: String, avatar: Data) -> Result<UserData, ApiError> {
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
                newUser.posts = []
                newUser.photos = []
                newUser.likedPosts = []
                
                try context.save()
                return .success(newUser)
            } else {
                return .failure(.suchUserAlreadyExists)
            }
        } catch {
            return .failure(.authError(message: "Unexpected error: \(error.localizedDescription)"))
        }
    }
    
    // Создаем новый пост
    func addPost(author: String, date: String, image: Data, postDescription: String) -> PostData{
        let context = persistentContainer.viewContext
        let post = PostData(context: context)
        
        post.id = UUID()
        post.author = author
        post.date = date
        post.image = image
        post.likes = 0
        post.isLiked = false
        post.postDescription = postDescription
        saveContext()
        return post
    }
    
    // Удаление поста
    func deletePost(by post: PostData) {
        let context = persistentContainer.viewContext
        context.delete(post)  // Directly delete the post object
        
        // Save the context to persist the deletion
        saveContext()
    }
    
    func likePost(user: UserData, post: PostData) {
        _ = persistentContainer.viewContext
        
        // Update the like state and the like count of the post
        post.isLiked.toggle()
        post.likes = post.isLiked ? post.likes + 1 : post.likes - 1
        
        // Add or remove the post from the liked posts of the user
        if post.isLiked {
            user.addToLikedPosts(post)
        } else {
            user.removeFromLikedPosts(post)
        }
        
        // Save the changes to Core Data
        saveContext()
    }
       
    // Создаем новое
    func addPhoto(date: String, image: Data) -> PhotoData{
        let context = persistentContainer.viewContext
        let photo = PhotoData(context: context)
        
        photo.id = UUID()
        photo.date = date
        photo.image = image
        saveContext()
        return photo
    }
    
    func deletePhoto(by photo: PhotoData) {
        let context = persistentContainer.viewContext
        context.delete(photo)  // Directly delete the post object
        
        // Save the context to persist the deletion
        saveContext()
    }
    
    
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

