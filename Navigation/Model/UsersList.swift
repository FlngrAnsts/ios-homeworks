//
//  Users.swift
//  Navigation
//
//  Created by Anastasiya on 10.06.2024.
//

import UIKit

var users: [User] = [
    User(
        login: "Grivus",
        fullName: "General Grivus",
       password: "123",
        avatar: UIImage(named: "grivus")!,
        status: "Уничтожить их! Но сперва помучить!"
    ),
    User(
        login: "CT-7567",
        fullName: "Capitan Rex",
        password: "456",
        avatar: UIImage(named: "Rex")!,
        status: "Меня зовут Рекс. Но для вас я - Капитан"
    ),
    User(
        login: "Vader",
        fullName: "Darth Vader",
        password: "",
        avatar: UIImage(named: "Vader")!,
        status: "Не задохнитесь от своих амбиций"
    )
]
