//
//  LoginFactory.swift
//  Navigation
//
//  Created by Anastasiya on 11.06.2024.
//

import UIKit

protocol LoginFactory{
    static func makeLoginInspector() -> LoginInspector
}
