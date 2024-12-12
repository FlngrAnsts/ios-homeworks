//
//  BaseController.swift
//  Navigation
//
//  Created by Anastasiya on 14.06.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
}

extension Coordinator{
    func add(coordinator: Coordinator){
        childCoordinators.append(coordinator)
    }
    func remove(coordinator: Coordinator){
        childCoordinators = childCoordinators.filter{$0 !== coordinator}
    }
}
