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
        
        self.view.backgroundColor = .lightGray
        self.navigationItem.title = "Profile"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white // your colour here
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(profileHeaderView)
        
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

                
            ])
        }
    
}
