//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Anastasiya on 14.06.2024.
//

import UIKit
import StorageService



class FeedCoordinator: Coordinator {
    
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
        showFeed()
    }
    
    func showFeed(){
        
        let feedVC = FeedViewController()
        feedVC.coordinator = self
        navigationController.pushViewController(feedVC, animated: true)
    }
    
    
}
