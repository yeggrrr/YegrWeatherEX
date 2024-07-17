//
//  EtcInfoCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit

final class EtcInfoCell: BaseCollectionViewCell {
    private let verticalStackView = UIStackView()
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
            $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            $0.bottom.lessThanOrEqualTo(contentView.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    override func configureUI() {
        contentView.backgroundColor = UIColor.systemFill.withAlphaComponent(0.3)
        contentView.layer.cornerRadius = 15
        
        verticalStackView.setUI(asisSV: .vertical, spacingSV: 10, alignmentSV: .fill, distributionSV: .fillProportionally)
        titleLabel.setUI(txtColor: .lightText, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .semibold))
        descriptionLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 35, weight: .medium))
        firstDetailInfoLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 15, weight: .regular))
        secondDetailInfoLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .regular))
    }
}
