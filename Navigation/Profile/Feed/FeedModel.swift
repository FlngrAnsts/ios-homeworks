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
}
