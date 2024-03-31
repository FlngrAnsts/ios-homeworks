//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        if let profileView = Bundle.main.loadNibNamed(
            "ProfileHeaderView",
            owner: nil,
            options: nil
        )?.first as? ProfileHeaderView {
            view.addSubview(profileView)
            
        }
        
        
    }

    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//    }

   // viewWillLayoutSubviews()
    
}
