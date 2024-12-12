//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Anastasiya on 14.06.2024.
//

import UIKit
import FirebaseAuth

class ProfileCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController : UINavigationController
    
    func getNavigationController() -> UINavigationController{
        return self.navigationController
    }
    var isAuthorized = false
    var user:User?
    
    init() {
        self.navigationController = UINavigationController()
        var viewController: UIViewController?
//        if Auth.auth().currentUser != nil  {
        if isAuthorized{
            viewController = getProfileViewController()
        }else{
            viewController = getLoginViewController()
        }
        
        
        viewController?.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
        self.navigationController = UINavigationController(rootViewController: viewController!)
    }
    
    func routeToProfile(user: User){
        let profileViewController = getProfileViewController()
        profileViewController.user = user
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func routeToLogin(){
        let loginViewConntroller = getLoginViewController()
        navigationController.pushViewController(loginViewConntroller, animated: true)
    }
    
    func routeToPhoto(){
        let photosViewController = PhotosViewController()
        self.navigationController.pushViewController(photosViewController, animated: true)
        
    }
    
    func getLoginViewController() -> LogInViewController{
        var userService: UserService = CurrentUserService()
        
#if DEBUG
        userService = TestUserService()
#endif
        let loginViewConntroller = LogInViewController(userService: userService, delegate: MyLoginFactory().makeLoginInspector())
        loginViewConntroller.routeToProfile = routeToProfile
        return loginViewConntroller
    }
    
    func getProfileViewController() -> ProfileViewController{
        
        let post = PostService()
        let profileVM = ProfileViewModel(service: post)
        let profileController = ProfileViewController(viewModel: profileVM)
        profileController.routeToPhoto = routeToPhoto
        return profileController
    }
    
    
}


