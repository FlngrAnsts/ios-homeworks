//
//  LoginInspector.swift
//  Navigation
//
//  Created by Anastasiya on 10.06.2024.
//

import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
        }
    
}
