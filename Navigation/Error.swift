//
//  Error.swift
//  Navigation
//
//  Created by Anastasiya on 27.06.2024.
//

import Foundation

enum LogInError : Error{
    
    case userNotFound
    case userNotFoundAndWrongPassword
    case suchUserAlreadyExists
    case weakPass
    case incorrectEmail
    case authorized
    case authError(message: String)
}
