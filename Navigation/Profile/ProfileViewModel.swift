//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Anastasiya on 13.06.2024.
//

import UIKit
import StorageService

final class ProfileViewModel: ProfileVMProtocol{
    
    private let service: PostService
    var currentState: ((State) -> Void)?
    
    var state: State = .initial {
        didSet {
            print(state)
            currentState?(state)
        }
    }
    
    init(service: PostService) {
        self.service = service
    }
    
    func changeStateIfNeeded() {
        state = .loading
        service.fetchPosts { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let post):
                    state = .loaded(post)
                case .failure(_):
                    state = .error
            }
        }
    }
    
}
