//
//  LikeDataManager.swift
//  Navigation
//
//  Created by Anastasiya on 11.09.2024.
//

import Foundation
import UIKit
import CoreData
import StorageService

final class LikeDataManager {
    
    static let shared = LikeDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved error \(error)")
            }
        })
        
        return container
    }()
    
    
    func getLikePost() -> [LikePost]{
        let request = LikePost.fetchRequest()
        return (try? persistentContainer.viewContext.fetch(request)) ?? []
    }
    
    func getLikeFilterPost(author: String) -> [LikePost]{
        let request = LikePost.fetchRequest()
        request.predicate = NSPredicate(format: "author CONTAINS[c] %@", author)
        return (try? persistentContainer.viewContext.fetch(request)) ?? []
    }
    
    func addLikePost(post: Post/*, in viewController: UIViewController*/){

//        persistentContainer.performBackgroundTask { [weak self] backContext in
//            guard let self else {
//                return
//            }
//            let likePost = LikePost(context: persistentContainer.viewContext)
//            likePost.id = Int16(post.id)
//            likePost.author = post.author
//            likePost.image = post.image
//            likePost.likes = Int16(post.likes)
//            likePost.views = Int16(post.views)
//            likePost.postDescription = post.postDescription
//            try? backContext.save()
//        }
        
        persistentContainer.performBackgroundTask { [weak self] backContext in
            guard let self = self else {
                return
            }
            
            // Проверяем уникальность
            let fetchRequest: NSFetchRequest<LikePost> = LikePost.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", Int16(post.id))
            
            do {
                let results = try backContext.fetch(fetchRequest)
                if results.isEmpty {
                    // Если объект не найден, создаем новый
                    let likePost = LikePost(context: backContext)
                    likePost.id = Int16(post.id)
                    likePost.author = post.author
                    likePost.image = post.image
                    likePost.likes = Int16(post.likes)
                    likePost.views = Int16(post.views)
                    likePost.postDescription = post.postDescription
                    
                    // Сохраняем контекст
                    try backContext.save()
                    
                    print("Лайк добавлен")
                } else {
                    print("Лайк для этого поста уже существует")
                }
            } catch {
                print("Ошибка при выполнении запроса: \(error.localizedDescription)")
            }
        }
    }
    
    
    func deleteLikePost(likePost: LikePost, completion: @escaping () -> Void){
        persistentContainer.performBackgroundTask { backContext in
            
            let context = likePost.managedObjectContext
            context?.delete(likePost)
            try? backContext.save()
            completion()
        }
    }
        
}
