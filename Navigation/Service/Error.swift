//
//  Error.swift
//  Navigation
//
//  Created by Anastasiya on 27.06.2024.
//

import Foundation
import UIKit

enum ApiError : Error{
    
    case userNotFoundAndWrongPassword
    case suchUserAlreadyExists
    case weakPass
    case authorized
    case authError(message: String)
    
    var localizedDescription: String {
        switch self{
        case .userNotFoundAndWrongPassword:
            return "User not found or wrong password".localized
        case .suchUserAlreadyExists:
            return "This user is already registered".localized
        case .weakPass:
            return "Password must be more than 6 characters long".localized
        case .authorized:
            return "New user successfully registered".localized 
        case .authError(message: let message):
            return message
        }
    }
    
}


