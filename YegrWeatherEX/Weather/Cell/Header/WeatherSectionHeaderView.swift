//
//  WeatherSectionHeaderView.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/14/24.
//

import UIKit
import SnapKit

final class WeatherSectionHeaderView: UICollectionReusableView {
    private let containerView = UIView()
    let iconImage = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHeaderView() {
        addSubview(containerView)
        containerView.addSubview(iconImage)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        iconImage.snp.makeConstraints {
            $0.centerY.equalTo(containerView.snp.centerY)
            $0.leading.equalTo(containerView.snp.leading).offset(10)
            $0.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(containerView.snp.verticalEdges).inset(5)
            $0.leading.equalTo(iconImage.snp.trailing).offset(5)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-10)
        }
        
        iconImage.tintColor = .white
        iconImage.image = UIImage(systemName: "calendar")
        titleLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .bold))
    }
}
