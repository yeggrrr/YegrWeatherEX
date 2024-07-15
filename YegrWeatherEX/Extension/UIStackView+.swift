//
//  UIStackView+.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/15/24.
//

import UIKit

extension UIStackView {
    func setUI(asisSV: NSLayoutConstraint.Axis, spacingSV: CGFloat, alignmentSV: Alignment, distributionSV: Distribution) {
        axis = asisSV
        spacing = spacingSV
        alignment = alignmentSV
        distribution = distributionSV
    }
}
