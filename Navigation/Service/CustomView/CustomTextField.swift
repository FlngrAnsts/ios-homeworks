//
//  CustomTextField.swift
//  Navigation
//
//  Created by Anastasiya on 20.12.2024.
//

import Foundation
import UIKit

final class CustomTextField: UITextField {
    
//    enum StatusTextField {
//        case onlyPhoneNumber, onlySMSCode, defaultTextFiled
//    }
//    
//    var statusOfTextFielrd: StatusTextField = .defaultTextFiled
    
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
//        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//extension CustomTextField: UITextFieldDelegate {
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        //        view.endEditing(true)
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        switch statusOfTextFielrd {
//        case .onlyPhoneNumber:
//            guard let currentText: String = textField.text else {return true}
//            if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil { return false }
//            let newCount: Int = currentText.count + string.count - range.length
//            let addingCharacter: Bool = range.length <= 0
//            if(newCount == 1){
//                textField.text = addingCharacter ? currentText + "+7 (\(string)" : String(currentText.dropLast(2))
//                return false
//            }else if(newCount == 8){
//                textField.text = addingCharacter ? currentText + ") \(string)" : String(currentText.dropLast(2))
//                return false
//            }else if(newCount == 13){
//                textField.text = addingCharacter ? currentText + "-\(string)" : String(currentText.dropLast(2))
//                return false
//            }
//            if(newCount > 17){
//                return false
//            }
//            return true
//        case .onlySMSCode:
//            guard let textFieldText = textField.text,
//                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
//                return false
//            }
//            let substringToReplace = textFieldText[rangeOfTextToReplace]
//            let count = textFieldText.count - substringToReplace.count + string.count
//            return count <= 4
//        case .defaultTextFiled:
//            return true
//        }
//    }
//    
//}
