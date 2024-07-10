//
//  MainView.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/10/24.
//

import UIKit
import SnapKit

final class MainView: UIView {
    private let scrollView = UIScrollView()
    private let backgroundView = UIView()
    
    private let topTitleView = UIView()
    let locationLabel = UILabel()
    let currentTempLabel = UILabel()
    let currentWeatherLabel = UILabel()
    let highestTempLabel = UILabel()
    let lowestTempLabel = UILabel()
    private let dividerView = UIView()
    
    private let everyThreeHoursView = UIView()
    
    private let weatherForecastView = UIView()
    
    private let bottomButtonView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        
        backgroundView.addSubview(topTitleView)
        topTitleView.addSubview(locationLabel)
        topTitleView.addSubview(currentTempLabel)
        topTitleView.addSubview(currentWeatherLabel)
        topTitleView.addSubview(highestTempLabel)
        topTitleView.addSubview(dividerView)
        topTitleView.addSubview(lowestTempLabel)
        
        backgroundView.addSubview(everyThreeHoursView)
        backgroundView.addSubview(weatherForecastView)
        
        addSubview(bottomButtonView)
    }
    
    func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeArea)
            $0.bottom.equalTo(bottomButtonView.snp.top)
        }
        
        let scrollViewContent = scrollView.contentLayoutGuide
        let scrollViewFrame = scrollView.frameLayoutGuide
        
        backgroundView.snp.makeConstraints {
            $0.verticalEdges.equalTo(scrollViewContent.snp.verticalEdges)
            $0.horizontalEdges.equalTo(scrollViewFrame.snp.horizontalEdges)
        }
        
        topTitleView.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top)
            $0.horizontalEdges.equalTo(backgroundView.snp.horizontalEdges)
            $0.height.equalTo(320)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(topTitleView.snp.top).offset(30)
            $0.horizontalEdges.equalTo(topTitleView.snp.horizontalEdges).inset(20)
            $0.centerX.equalTo(topTitleView.snp.centerX)
            $0.height.equalTo(50)
        }
        
        currentTempLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom)
            $0.horizontalEdges.equalTo(topTitleView.snp.horizontalEdges).inset(20)
            $0.centerX.equalTo(topTitleView.snp.centerX)
            $0.height.equalTo(100)
        }
        
        currentWeatherLabel.snp.makeConstraints {
            $0.top.equalTo(currentTempLabel.snp.bottom)
            $0.horizontalEdges.equalTo(topTitleView.snp.horizontalEdges).inset(20)
            $0.centerX.equalTo(topTitleView.snp.centerX)
            $0.height.equalTo(35)
        }
        
        highestTempLabel.snp.makeConstraints {
            $0.trailing.equalTo(dividerView.snp.leading).offset(-10)
            $0.leading.equalTo(topTitleView.snp.leading).offset(20)
            $0.centerY.equalTo(dividerView.snp.centerY)
            $0.height.equalTo(35)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(currentWeatherLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(topTitleView.snp.centerX)
            $0.width.equalTo(2)
            $0.height.equalTo(30)
        }
        
        lowestTempLabel.snp.makeConstraints {
            $0.leading.equalTo(dividerView.snp.trailing).offset(10)
            $0.trailing.equalTo(topTitleView.snp.trailing).offset(-20)
            $0.centerY.equalTo(dividerView.snp.centerY)
            $0.height.equalTo(35)
        }
        
        everyThreeHoursView.snp.makeConstraints {
            $0.top.equalTo(topTitleView.snp.bottom)
            $0.horizontalEdges.equalTo(backgroundView.snp.horizontalEdges)
            $0.height.equalTo(200)
        }
        
        weatherForecastView.snp.makeConstraints {
            $0.top.equalTo(everyThreeHoursView.snp.bottom)
            $0.horizontalEdges.equalTo(backgroundView.snp.horizontalEdges)
            $0.bottom.equalTo(backgroundView.snp.bottom)
            $0.height.equalTo(320)
        }
        
        bottomButtonView.snp.makeConstraints {
            $0.bottom.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(70)
        }
    }
    
    func configureUI() {
        backgroundColor = .white
        
        backgroundView.backgroundColor = .systemGray
        
        topTitleView.backgroundColor = .darkGray
        everyThreeHoursView.backgroundColor = .systemGray4
        weatherForecastView.backgroundColor = .systemGray2
        
        bottomButtonView.backgroundColor = .systemGray5
        
        locationLabel.text = "Seoul City"
        locationLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 35, weight: .regular))
        
        currentTempLabel.text = "28º"
        currentTempLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 90, weight: .thin))
        
        currentWeatherLabel.text = "맑음"
        currentWeatherLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 20, weight: .regular))
        
        highestTempLabel.text = "최고: 31º"
        highestTempLabel.setUI(txtColor: .white, txtAlignment: .right, fontStyle: .systemFont(ofSize: 20, weight: .regular))
        
        dividerView.backgroundColor = .white
        
        lowestTempLabel.text = "최저: 25º"
        lowestTempLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 20, weight: .regular))
    }
}
