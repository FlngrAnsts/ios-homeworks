//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Anastasiya on 14.06.2024.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let tabBarController: TabBarController
    
    private let factory = ControllerFactoryImpl()
    
    
    init(){
        tabBarController = TabBarController()
        let profileCoordinator = configureProfile()
        let feedCoordinator = configureFeed()
        let likeCoordinator = configureLike()
        coordinators.append(profileCoordinator)
        coordinators.append(feedCoordinator)
        coordinators.append(likeCoordinator)
        
        tabBarController.viewControllers = [feedCoordinator.navigationController, profileCoordinator.navigationController, likeCoordinator.navigationController]
        tabBarController.selectedIndex = 1
        profileCoordinator.start()
        feedCoordinator.start()
        likeCoordinator.start()
    }
    
    private func configureProfile() -> ProfileCoordinator {
        
        let navigationProfile = UINavigationController()
        navigationProfile.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(
                systemName: "person.circle"
            ),
            tag: 1
        )
        let coordinator = ProfileCoordinator(navigationController: navigationProfile, factory: factory)
        
        return coordinator
    }
    
    private func configureFeed() -> FeedCoordinator {
        
        let navigationFeed = UINavigationController()
        navigationFeed.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(
                systemName: "doc.richtext"
            ),
            tag: 0
        )
        let coordinator = FeedCoordinator(navigationController: navigationFeed, factory: factory)
        
        return coordinator
    }
    
    private func configureLike() -> LikeCoordinator {
        
        let navigationLike = UINavigationController()
        navigationLike.title = "Likes"
        navigationLike.tabBarItem = UITabBarItem(
            title: "Likes",
            image: UIImage(
                systemName: "heart"
            ),
            tag: 2
        )
        let coordinator = LikeCoordinator(navigationController: navigationLike, factory: factory)
        
        return coordinator
    }
}
