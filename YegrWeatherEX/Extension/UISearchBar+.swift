//
//  UISearchBar+.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/15/24.
//

import UIKit

extension UISearchBar {
    func setUI(placeholder: String) {
        showsCancelButton = true
        barTintColor = .white
        searchBarStyle = .minimal
        searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        searchTextField.leftView?.tintColor = .white
        searchTextField.textColor = .white
        keyboardType = .asciiCapable
        keyboardAppearance = .light
    }
}
