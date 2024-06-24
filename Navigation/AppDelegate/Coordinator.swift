//
//  BaseController.swift
//  Navigation
//
//  Created by Anastasiya on 14.06.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] {get set}
}

