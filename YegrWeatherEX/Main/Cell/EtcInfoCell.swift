//
//  EtcInfoCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit

class EtcInfoCell: BaseCollectionViewCell {
    let verticalStackView = UIStackView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let firstDetailInfoLabel = UILabel()
    let secondDetailInfoLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        verticalStackView.addArrangedSubview(firstDetailInfoLabel)
        verticalStackView.addArrangedSubview(secondDetailInfoLabel)
    }
    
    override func configureLayout() {
        verticalStackView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide).inset(15)
        }
    }
    
    override func configureUI() {
        backgroundColor = .systemOrange
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
    }
}
