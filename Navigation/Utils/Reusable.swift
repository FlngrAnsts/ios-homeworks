//
//  Reusable.swift
//  Navigation
//
//  Created by Anastasiya on 28.05.2024.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
