//
//  CustomLabel.swift
//  Navigation
//
//  Created by Anastasiya on 29.12.2024.
//

import Foundation
import UIKit

final class CustomLabel: UILabel {

    init(fontSize: Int, textColor: UIColor)  {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.textColor = .customTextColor
        self.font = UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
