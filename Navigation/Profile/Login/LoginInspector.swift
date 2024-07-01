//
//  LoginInspector.swift
//  Navigation
//
//  Created by Anastasiya on 10.06.2024.
//

import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    
    let checkerService : CheckerServiceProtocol
        
        init(checkerService: CheckerServiceProtocol){
            self.checkerService = checkerService
        }
    
    func check(login: String, password: String, completion: @escaping (Result<String, LogInError>) -> Void) throws {
        
        checkerService.checker(login: login, password: password, completion: completion)
        
        }
    
    
}
