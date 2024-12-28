//
//  LikeCoordinator.swift
//  Navigation
//
//  Created by Anastasiya on 11.09.2024.
//

import UIKit
import StorageService

class LikeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController : UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
            let likeVC = LikePostTableViewController()
            likeVC.title = "Liked posts"
            likeVC.tabBarItem = UITabBarItem(title: "like", image: UIImage(systemName: "heart"), tag: 2)
            self.navigationController = UINavigationController(rootViewController: likeVC)
    }
    
    
}
