//
//  CurrentInfoCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit

class CurrentInfoCell: BaseCollectionViewCell {
    let todayView = TodayView()
    
    override func configureHierarchy() {
        contentView.addSubview(todayView)
    }
    
    override func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        todayView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
    }
}
