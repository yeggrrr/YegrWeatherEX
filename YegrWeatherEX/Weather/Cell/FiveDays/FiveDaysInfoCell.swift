//
//  FiveDaysInfoCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit
import Kingfisher

final class FiveDaysInfoCell: BaseCollectionViewCell {
    let dateLabel = UILabel()
    let weatherImage = UIImageView()
    let lowestTempLabel = UILabel()
    let highestTempLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(lowestTempLabel)
        contentView.addSubview(highestTempLabel)
    }
    
    override func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(safeArea).offset(20)
            $0.verticalEdges.equalTo(safeArea).inset(10)
            $0.width.equalTo(50)
        }
        
        weatherImage.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(20)
            $0.centerY.equalTo(safeArea.snp.centerY)
            $0.width.height.equalTo(30)
        }
        
        lowestTempLabel.snp.makeConstraints {
            $0.leading.equalTo(weatherImage.snp.trailing).offset(20)
            $0.centerY.equalTo(safeArea.snp.centerY)
        }
        
        highestTempLabel.snp.makeConstraints {
            $0.leading.equalTo(lowestTempLabel.snp.trailing).offset(30)
            $0.centerY.equalTo(safeArea.snp.centerY)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-20)
        }
    }
    
    override func configureUI() {
        dateLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 23, weight: .regular))
        lowestTempLabel.setUI(txtColor: .lightGray, txtAlignment: .center, fontStyle: .systemFont(ofSize: 23, weight: .regular))
        highestTempLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 23, weight: .regular))
    }
    
    func setImage(iconName: String?) {
        guard let iconName = iconName else { return }
        let imageURL = URL(string: "\(ImageURL.imageURL)\(iconName)@2x.png")
        weatherImage.kf.setImage(with: imageURL)
    }
}
