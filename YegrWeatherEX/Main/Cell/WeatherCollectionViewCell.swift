//
//  WeatherCollectionViewCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/11/24.
//

import UIKit
import SnapKit

class WeatherCollectionViewCell: BaseCollectionViewCell {
    let timeLabel = UILabel()
    let weatherImage = UIImageView()
    let tempLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(tempLabel)
    }
    
    override func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(10)
            $0.horizontalEdges.equalTo(safeArea.snp.horizontalEdges).inset(10)
            $0.height.equalTo(30)
        }
        
        weatherImage.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(20)
            $0.centerX.equalTo(timeLabel.snp.centerX)
            $0.height.width.equalTo(30)
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(weatherImage.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea.snp.horizontalEdges).inset(10)
            $0.bottom.equalTo(safeArea).offset(-10)
        }
    }
    
    override func configureUI() {
        contentView.backgroundColor = .clear
        
        // 임시
        timeLabel.text = "12시"
        tempLabel.text = "26º"
        
        timeLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 17, weight: .regular))
        tempLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 17, weight: .regular))
        
        weatherImage.image = UIImage(systemName: "cloud.fill")
        weatherImage.tintColor = .white
    }
}
