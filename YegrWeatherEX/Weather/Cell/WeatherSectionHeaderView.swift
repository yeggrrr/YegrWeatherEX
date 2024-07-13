//
//  WeatherSectionHeaderView.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/14/24.
//

import UIKit
import SnapKit


class WeatherSectionHeaderView: UICollectionReusableView {
    let containerView = UIView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(containerView.snp.verticalEdges).inset(5)
            $0.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(10)
        }
        
        titleLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .bold))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
