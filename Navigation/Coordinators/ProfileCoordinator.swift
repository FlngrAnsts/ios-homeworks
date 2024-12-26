//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Anastasiya on 14.06.2024.
//

import UIKit
import Foundation

class ProfileCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    var isAuthorized: Bool {
        // Проверяем, есть ли авторизованный пользователь в Core Data
        return CoreDataManager.shared.fetchAuthorizedUser() != nil
    }
    
    var currentUser: UserData? {
        // Получаем авторизованного пользователя из Core Data
        return CoreDataManager.shared.fetchAuthorizedUser()
    }
    
    init() {
        self.navigationController = UINavigationController()
        
        let initialViewController: UIViewController
        if isAuthorized, let user = currentUser {
            initialViewController = getProfileViewController(user: user)
        } else {
            initialViewController = getLoginViewController()
        }
        
        initialViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
        self.navigationController = UINavigationController(rootViewController: initialViewController)
    }
    
    // Маршрут на экран профиля
    func routeToProfile(user: UserData) {
        let profileViewController = getProfileViewController(user: user)
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    // Маршрут на экран входа
    func routeToLogin() {
        let loginViewController = getLoginViewController()
        navigationController.pushViewController(loginViewController, animated: false)
    }
    // Маршрут на экран входа
    func routeToRegistration() {
        let registrationViewController = RegistrationViewController()
        registrationViewController.routeToProfile = { [weak self] user in
            guard let self = self else { return }
            // После регистрации сохраняем пользователя и маршрутизируем на профиль
            CoreDataManager.shared.authorizeUser(user: user)
            self.routeToProfile(user: user)
        }
        navigationController.pushViewController(registrationViewController, animated: true)
    }
    
    // Маршрут на экран фотографий
    func routeToPhoto() {
        let photosViewController = PhotosViewController()
        navigationController.pushViewController(photosViewController, animated: true)
    }
    
    // Получение контроллера входа
    func getLoginViewController() -> LogInViewController {
        let loginViewController = LogInViewController()
        loginViewController.routeToProfile = { [weak self] user in
            guard let self = self else { return }
            // После авторизации сохраняем пользователя и маршрутизируем на профиль
            CoreDataManager.shared.authorizeUser(user: user)
            self.routeToProfile(user: user)
        }
        loginViewController.routeToRegistration = {self.routeToRegistration()}
       
        return loginViewController
    }
    
    // Получение контроллера профиля
    func getProfileViewController(user: UserData) -> ProfileViewController {
        let profileViewController = ProfileViewController(user: user)
        profileViewController.routeToLogin = { //[weak self] user in
            //                guard let self = self else { return }
            // После авторизации сохраняем пользователя и маршрутизируем на профиль
            CoreDataManager.shared.logoutUser(user: user)
            self.routeToLogin()
        }
        return profileViewController
    }
    
    func getRegistrationViewController() -> RegistrationViewController {
        let registrationViewController = RegistrationViewController()
        registrationViewController.routeToProfile = { [weak self] user in
            guard let self = self else { return }
            // После успешной регистрации сохраняем нового пользователя и переходим на профиль
            CoreDataManager.shared.authorizeUser(user: user)
            self.routeToProfile(user: user)
        }
        return registrationViewController
    }
    
    
    
    
    //    var childCoordinators: [Coordinator] = []
    //    var navigationController : UINavigationController
    //
    //    func getNavigationController() -> UINavigationController{
    //        return self.navigationController
    //    }
    //    var isAuthorized = false
    //    var user:UserData
    //
    //    init() {//var user: UserData?
    //
    //        self.navigationController = UINavigationController()
    //        var viewController: UIViewController?
    //        if isAuthorized{
    //            viewController = getProfileViewController()
    //        } else {
    //            viewController = getLoginViewController()
    //        }
    //
    ////        if CurrentProfileService.shared.featchCurrentProfile() == nil {
    ////            viewController = getLoginViewController()
    ////        } else {
    ////            CoreDataManager.shared.getUser()
    ////            viewController = getProfileViewController()
    ////
    ////        }
    //
    //        viewController?.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
    //        self.navigationController = UINavigationController(rootViewController: viewController!)
    //
    //    }
    //
    //    func routeToProfile(user: User){
    //            let profileViewController = getProfileViewController()
    ////            profileViewController.user = user
    //            navigationController.pushViewController(profileViewController, animated: true)
    //        }
    //
    //        func routeToLogin(){
    //            let loginViewConntroller = getLoginViewController()
    //            navigationController.pushViewController(loginViewConntroller, animated: true)
    //        }
    //
    //        func routeToPhoto(){
    //            let photosViewController = PhotosViewController()
    //            self.navigationController.pushViewController(photosViewController, animated: true)
    //        }
    //
    //        func getLoginViewController() -> LogInViewController{
    //
    //            let loginViewConntroller = LogInViewController(/*userService: userService, delegate: MyLoginFactory().makeLoginInspector()*/)
    //            loginViewConntroller.routeToProfile = routeToProfile
    //            return loginViewConntroller
    //        }
    //
    //        func getProfileViewController() -> ProfileViewController{
    //
    //
    //            let profileController = ProfileViewController(user: user)
    ////            profileController.routeToPhoto = routeToPhoto
    //            return profileController
    //        }
    //
    ////    func routeToProfile(user: User){
    ////        let profileViewController = getProfileViewController()
    ////        profileViewController.user = user
    ////        navigationController.pushViewController(profileViewController, animated: true)
    ////    }
    ////
    ////    func routeToPhoto(){
    ////        let photosViewController = PhotosViewController()
    ////        self.navigationController.pushViewController(photosViewController, animated: true)
    ////
    ////    }
    ////
    ////
    ////    func getProfileViewController() -> ProfileViewController{
    ////
    ////        let profileVM = ProfileViewModel()
    ////        let profileController = ProfileViewController(viewModel: profileVM)
    ////        profileController.routeToPhoto = routeToPhoto
    ////        return profileController
    ////    }
    
    
}


