//
//  SearchTableViewCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/11/24.
//

import UIKit
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    private let nameStackView = UIStackView()
    let regionLabel = UILabel()
    let countryLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(nameStackView)
        nameStackView.addArrangedSubview(regionLabel)
        nameStackView.addArrangedSubview(countryLabel)
    }
    
    override func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        let height = contentView.frame.height
        
        nameStackView.snp.makeConstraints {
            $0.edges.equalTo(safeArea.snp.edges).inset(5)
        }
        
        regionLabel.snp.makeConstraints {
            $0.height.equalTo(height / 2)
        }
        
        countryLabel.snp.makeConstraints {
            $0.height.equalTo(height / 2)
        }
    }
    
    override func configureUI() {
        nameStackView.setUI(asisSV: .vertical, spacingSV: 0, alignmentSV: .fill, distributionSV: .fillEqually)
        regionLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .bold))
        countryLabel.setUI(txtColor: .lightGray, txtAlignment: .left, fontStyle: .systemFont(ofSize: 15, weight: .regular))
        regionLabel.text = "지역이름"
        countryLabel.text = "나라이름"
    }
}
