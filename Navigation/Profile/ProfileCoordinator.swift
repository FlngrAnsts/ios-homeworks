//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Anastasiya on 14.06.2024.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    var navigationController : UINavigationController
    
    private var factory: ControllerFactory
    
    
    var isAuthorized = false
    var user:User?
    
    init(navigationController: UINavigationController, factory: ControllerFactory) {
        
        self.navigationController = navigationController
        self.factory = factory
    }
    
    
    func start(){
        if isAuthorized{
            showProfile()
        } else{
            showLogIn()
        }
    }
    
    func showLogIn(){
        let viewModel = LoginViewModel()
        let logInVC = LogInViewController(viewModel: viewModel)
        let factory = MyLoginFactory()
        viewModel.loginDelegate = factory.makeLoginInspector()
        logInVC.coordinator = self
        navigationController.pushViewController(logInVC, animated: true)
    }
    
    func showProfile(){
        let service = PostService()
        let viewModel = ProfileViewModel(service: service)
        let profileVC = ProfileViewController(viewModel: viewModel)
        profileVC.user = self.user
        profileVC.coordinator = self
        
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(profileVC, animated: true)
                
    }
    
    func showPhotos() {
        let photosVC = PhotosViewController()
        photosVC.coordinator = self
        navigationController.pushViewController(photosVC, animated: true)
        }
    
    
}


