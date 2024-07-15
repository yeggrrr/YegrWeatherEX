//
//  TodayView.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit

final class TodayView: UIView {
    private let tempView = UIView()
    
    let locationLabel = UILabel()
    let currentTempLabel = UILabel()
    let currentWeatherLabel = UILabel()
    
    private let highLowTempStackView = UIStackView()
    let highestTempLabel = UILabel()
    let dividerLabel = UILabel()
    let lowestTempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(tempView)
        tempView.addSubview(locationLabel)
        tempView.addSubview(currentTempLabel)
        tempView.addSubview(currentWeatherLabel)
        tempView.addSubview(highLowTempStackView)
        highLowTempStackView.addArrangedSubview(highestTempLabel)
        highLowTempStackView.addArrangedSubview(dividerLabel)
        highLowTempStackView.addArrangedSubview(lowestTempLabel)
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        tempView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeArea.snp.horizontalEdges)
            $0.centerY.equalTo(safeArea.snp.centerY)
            $0.height.equalTo(300)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(tempView.snp.top).offset(30)
            $0.horizontalEdges.equalTo(tempView.snp.horizontalEdges).inset(20)
            $0.height.equalTo(50)
        }
        
        currentTempLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom)
            $0.horizontalEdges.equalTo(tempView.snp.horizontalEdges).inset(20)
            $0.height.equalTo(100)
        }
        
        currentWeatherLabel.snp.makeConstraints {
            $0.top.equalTo(currentTempLabel.snp.bottom)
            $0.horizontalEdges.equalTo(tempView.snp.horizontalEdges).inset(20)
            $0.height.equalTo(35)
        }
        
        highLowTempStackView.snp.makeConstraints {
            $0.top.equalTo(currentWeatherLabel.snp.bottom)
            $0.horizontalEdges.equalTo(tempView.snp.horizontalEdges).inset(20)
            $0.bottom.lessThanOrEqualTo(tempView.snp.bottom)
        }
        
        highestTempLabel.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        dividerLabel.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        lowestTempLabel.snp.makeConstraints {
            $0.height.equalTo(35)
        }
    }
    
    private func configureUI() {
        locationLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 40, weight: .regular))
        currentTempLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 80, weight: .thin))
        currentWeatherLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 20, weight: .regular))
        highLowTempStackView.setUI(asisSV: .horizontal, spacingSV: 10, alignmentSV: .center, distributionSV: .fillProportionally)
        highestTempLabel.setUI(txtColor: .white, txtAlignment: .right, fontStyle: .systemFont(ofSize: 20, weight: .regular))
        lowestTempLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 20, weight: .regular))
        dividerLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 20, weight: .semibold))
    }
}
