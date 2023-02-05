//
//  UITextField+Extension.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2022-12-27.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    
    func enablePasswordToggle() {
        passwordToggleButton.setImage(UIImage(systemName: "eyebrow"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eyes"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(passwordToggleButtonPressed), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func passwordToggleButtonPressed() {
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
