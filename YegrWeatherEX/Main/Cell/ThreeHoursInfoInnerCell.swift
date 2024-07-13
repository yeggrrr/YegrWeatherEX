//
//  ThreeHoursInfoInnerCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit

class ThreeHoursInfoInnerCell: BaseCollectionViewCell {
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
            $0.top.equalTo(timeLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(timeLabel.snp.centerX)
            $0.height.width.equalTo(40)
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(weatherImage.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeArea.snp.horizontalEdges).inset(10)
            $0.bottom.equalTo(safeArea).offset(-10)
        }
    }
    
    override func configureUI() {
        timeLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 17, weight: .regular))
        tempLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 17, weight: .regular))
    }
    
    func setImage(iconName: String?) {
        guard let iconName = iconName else { return }
        let imageURL = URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")
        weatherImage.kf.setImage(with: imageURL)
    }
}
