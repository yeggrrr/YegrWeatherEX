//
//  ReusableProtocol+.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/10/24.
//

import UIKit

protocol ReusableProtocol: AnyObject {
    static var id: String { get }
}

extension UIView: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
}
