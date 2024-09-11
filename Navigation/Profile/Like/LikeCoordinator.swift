//
//  LikeCoordinator.swift
//  Navigation
//
//  Created by Anastasiya on 11.09.2024.
//

import UIKit
import StorageService

class LikeCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    var navigationController : UINavigationController
    
    
    private var factory: ControllerFactory
    private lazy var feedModule = {
        factory.makeFeed()
    }()
    
    init(navigationController: UINavigationController, factory: ControllerFactory) {
        
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start(){
        showLike()
    }
    
    func showLike(){
        
        let likeVC = LikePostTableViewController()
        likeVC.coordinator = self
        navigationController.pushViewController(likeVC, animated: true)
    }
    
    
    
    
}
