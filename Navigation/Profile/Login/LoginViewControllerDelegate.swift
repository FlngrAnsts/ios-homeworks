//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Anastasiya on 10.06.2024.
//

import UIKit

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}
