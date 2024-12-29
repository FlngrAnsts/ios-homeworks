//
//  CustomTextField.swift
//  Navigation
//
//  Created by Anastasiya on 20.12.2024.
//

import Foundation
import UIKit

final class CustomTextField: UITextField {

    init(placeholder: String, isSecure: Bool, cornerRadius: CACornerMask) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray6
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecure

        self.borderStyle = .roundedRect
        self.autocorrectionType = .no
        self.keyboardType = .default
        self.returnKeyType = .done
        self.clearButtonMode = .whileEditing
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = cornerRadius
        self.clipsToBounds = true
        self.textColor = .customTextColor
        self.font = UIFont.boldSystemFont(ofSize: 16)
        self.autocapitalizationType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

