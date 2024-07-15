//
//  UITableView+.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/15/24.
//

import UIKit

extension UITableView {
    func setUI() {
        keyboardDismissMode = .onDrag
        backgroundColor = .clear
        separatorStyle = .singleLine
        separatorColor = .white
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
