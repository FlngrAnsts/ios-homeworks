//
//  PostService.swift
//  Navigation
//
//  Created by Anastasiya on 13.06.2024.
//

import StorageService

class PostService{
    let post = Post.make()
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        // Имитирует запрос данных из сети (делая паузу в 3 секунды)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            guard let self else { return}
            // Главное
            completion(.success(post))
        })
    }
    
}
