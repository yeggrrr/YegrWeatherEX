//
//  CurrentInfoCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit

final class CurrentInfoCell: BaseCollectionViewCell {
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
    
    func configureCell(currentInfoData:  CurrentInfoData) {
        todayView.locationLabel.text = currentInfoData.location
        todayView.currentTempLabel.text = currentInfoData.currentTemp
        todayView.currentWeatherLabel.text = currentInfoData.currentWeather
        todayView.highestTempLabel.text = currentInfoData.highestTemp
        todayView.lowestTempLabel.text = currentInfoData.lowestTemp
        todayView.dividerLabel.text = currentInfoData.divider
    }
}
