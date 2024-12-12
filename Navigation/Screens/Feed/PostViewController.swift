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
    
    var routeToInfo: () -> () = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        
        self.navigationItem.title = titlePost
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonBar(_:)))
        navigationItem.rightBarButtonItem = add
        
    }
    @objc func buttonBar(_ sender: UIButton) {
//        coordinator?.showInfo()
//        let infoVC = InfoViewController()
//        self.navigationController?.pushViewController(infoVC, animated: true)
//        infoVC.modalPresentationStyle = .overCurrentContext
//        infoVC.modalTransitionStyle = .coverVertical
//        present(infoVC, animated: true, completion: nil)
        routeToInfo()
    }
    
}
