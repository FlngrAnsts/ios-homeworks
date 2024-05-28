//
//  PostViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit
import StorageService

class PostViewController: UIViewController {
    
    var titlePost: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        
        self.navigationItem.title = titlePost
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonBar))
        navigationItem.rightBarButtonItem = add
        
    }
    @objc func buttonBar() {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .overCurrentContext
        infoVC.modalTransitionStyle = .coverVertical
        present(infoVC, animated: true, completion: nil)
        
    }
    
}
