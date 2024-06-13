//
//  FeedModel.swift
//  Navigation
//
//  Created by Anastasiya on 11.06.2024.
//

import UIKit

class FeedModel {
    private let secretWord = "Dark"
    
    func check (word: String) -> Bool {
        return word == secretWord
    }
//    func check(word: String, completion: @escaping (Result<Bool, Error>) -> Void) {
//        // Имитирует запрос данных из сети (делая паузу в 3 секунды)
//        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: { [weak self] in
//            guard let self else { return}
//            // Главное
//            completion(.success(word == secretWord))
//            completion(.failure(<#T##any Error#>))
//        })
//    }
}
