//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Anastasiya on 11.06.2024.
//

import UIKit

struct MyLoginFactory: LoginFactory{
    static func makeLoginInspector() -> LoginInspector{
        return LoginInspector()
    }
}
