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
    
    func getNavigationController() -> UINavigationController{
            return self.navigationController
        }
    
    init() {
        let feedViewController = LikePostTableViewController()
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "heart"), tag: 2)
        self.navigationController = UINavigationController(rootViewController: feedViewController)
        
    }
    


    
//    private var factory: ControllerFactory
//    private lazy var feedModule = {
//        factory.makeFeed()
//    }()
//    
//    init(navigationController: UINavigationController, factory: ControllerFactory) {
//        
//        self.navigationController = navigationController
//        self.factory = factory
//    }
//    
//    func start(){
//        showLike()
//    }
//    
//    func showLike(){
//        
//        let likeVC = LikePostTableViewController()
//        likeVC.coordinator = self
//        navigationController.pushViewController(likeVC, animated: true)
//    }
    
    
    
}
