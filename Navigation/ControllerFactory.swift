//
//  ControllerFactory.swift
//  Navigation
//
//  Created by Anastasiya on 24.06.2024.
//

import Foundation

protocol ControllerFactory {
    func makeFeed() -> (viewModel: FeedModel, controller: FeedViewController)
    
    func makeProfile() -> (viewModel: ProfileViewModel, controller: ProfileViewController)
}

struct ControllerFactoryImpl: ControllerFactory {
    func makeProfile() -> (viewModel: ProfileViewModel, controller: ProfileViewController) {

        let service = PostService()
        let viewModel = ProfileViewModel(service: service)
        let controller = ProfileViewController(viewModel: viewModel)
        return (viewModel, controller)
    }
    
    
    func makeFeed() -> (viewModel: FeedModel, controller: FeedViewController) {
        let viewModel = FeedModel()
        let controller = FeedViewController()
        return (viewModel, controller)
    }
}
