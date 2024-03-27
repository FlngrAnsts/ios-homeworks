//
//  InfoViewController.swift
//  Navigation
//
//  Created by Anastasiya on 28.03.2024.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var actionButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Кнопка", for: .normal)
            
            return button
        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        
        view.addSubview(actionButton)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
                NSLayoutConstraint.activate([
                    actionButton.leadingAnchor.constraint(
                        equalTo: safeAreaLayoutGuide.leadingAnchor,
                        constant: 20.0
                    ),
                    actionButton.trailingAnchor.constraint(
                        equalTo: safeAreaLayoutGuide.trailingAnchor,
                        constant: -20.0
                    ),
                    actionButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
                    actionButton.heightAnchor.constraint(equalToConstant: 44.0)
                ])
                
                actionButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    @objc func buttonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Вы принесли полотенце?", message: "Лучше возьмите с собой полотенце.", preferredStyle: .alert)
         
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
         
        self.present(alert, animated: true)
    }
    
}
