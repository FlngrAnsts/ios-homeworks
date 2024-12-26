//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Anastasiya on 14.06.2024.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let tabBarController: UITabBarController
    
    init(){
        self.tabBarController =  UITabBarController()
        let feedCoordinator = FeedCoordinator()
        let profileCoordinator = ProfileCoordinator()
        let likeCoordinator = LikeCoordinator()
        
        self.add(coordinator: feedCoordinator)
        self.add(coordinator: profileCoordinator)
        self.add(coordinator: likeCoordinator)
        
        // Получаем экран регистрации
        let registrationViewController = profileCoordinator.getRegistrationViewController()
        
        
        let controllers = [feedCoordinator.navigationController, profileCoordinator.navigationController, likeCoordinator.navigationController]
        tabBarController.viewControllers = controllers
//        tabBarController.selectedIndex = 0
        tabBarController.selectedIndex = 1
        UITabBar.appearance().backgroundColor = .white
    }
    

}
