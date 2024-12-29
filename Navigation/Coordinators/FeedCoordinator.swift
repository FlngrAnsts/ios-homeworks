//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Anastasiya on 14.06.2024.
//

import UIKit
import StorageService



class FeedCoordinator: Coordinator {
    
    
    var childCoordinators: [Coordinator] = []
    var navigationController : UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
        let feedVC: UIViewController
        feedVC = FeedViewController()
        feedVC.title = "Feed"
        feedVC.tabBarItem = UITabBarItem(title: "Feed".localized, image: UIImage(systemName: "doc.richtext"), tag: 0)
        self.navigationController = UINavigationController(rootViewController: feedVC)

    }
 
}
