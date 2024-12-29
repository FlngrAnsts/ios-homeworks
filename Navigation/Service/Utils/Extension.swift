//
//  Extension.swift
//  Navigation
//
//  Created by Anastasiya on 27.09.2024.
//

import UIKit

public extension UIViewController {
    
     func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
     func showSuccessAlert(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}


extension UIColor {
    static let customBackgroundColor: UIColor = {
          return UIColor { (traitCollection: UITraitCollection) -> UIColor in
              return traitCollection.userInterfaceStyle == .dark ? .black : .systemGray5
          }
      }()
    
    static let customTextColor: UIColor = {
          return UIColor { (traitCollection: UITraitCollection) -> UIColor in
              return traitCollection.userInterfaceStyle == .dark ? .white : .black
          }
      }()
    
    static let customPhotoBackgroundColor: UIColor = {
          return UIColor { (traitCollection: UITraitCollection) -> UIColor in
              return traitCollection.userInterfaceStyle == .dark ? .white : .black
          }
      }()
    
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
