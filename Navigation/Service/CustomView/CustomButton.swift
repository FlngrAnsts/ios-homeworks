//
//  CustomButton.swift
//  Navigation
//
//  Created by Anastasiya on 10.06.2024.
//

import UIKit

class CustomButton: UIButton {
    
    typealias Action = () -> Void

    var buttonAction: Action
    
    init(title: String, titleColor: UIColor, action: @escaping Action) {
        self.buttonAction = action
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.numberOfLines = 0
//        self.sizeToFit()
        self.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(_ sender: UIButton){
        buttonAction()
    }
    
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
}
