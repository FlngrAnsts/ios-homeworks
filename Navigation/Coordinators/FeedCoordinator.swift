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

    func getNavigationController() -> UINavigationController{
            return self.navigationController
        }
    
    init() {
        let feedViewController = FeedViewController()
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "doc.richtext"), tag: 0)
        self.navigationController = UINavigationController(rootViewController: feedViewController)
        
    }
 
}
