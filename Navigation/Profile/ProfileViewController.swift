//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit


class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white // your colour here
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        view.addSubview(profileHeaderView)
        profileHeaderView.frame = view.bounds
        
        profileHeaderView.setupContraints()
        
        setupContraints()
        
    }
    
    private func setupContraints() {
            let safeAreaGuide = view.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
                profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
                profileHeaderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
                profileHeaderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
//                redView.heightAnchor.constraint(equalToConstant: 300.0),
//                redView.widthAnchor.constraint(equalToConstant: 300.0),
//                redView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
//                redView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
                
            ])
        }
    
}
