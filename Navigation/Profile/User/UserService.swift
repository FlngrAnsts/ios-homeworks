//
//  UserService.swift
//  Navigation
//
//  Created by Anastasiya on 01.06.2024.
//

import UIKit

protocol UserService {
    var user: User { get set }
    func checkUser(login: String) -> User?
    
}
extension UserService {
    func checkUser(login: String) -> User? {
        return login == login ? user : nil
    }
    
}



