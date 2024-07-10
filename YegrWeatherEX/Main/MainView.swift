//
//  MainView.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/10/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    let scrollView = UIScrollView()
    let backgroundView = UIView()
    
    let topTitleView = UIView()
    let everyThreeHoursView = UIView()
    let weatherForecastView = UIView()
    
    let bottomButtonView = UIView()
    
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
        
        scrollView.backgroundColor = .systemCyan
        backgroundView.backgroundColor = .systemBrown
        
        topTitleView.backgroundColor = .systemRed
        everyThreeHoursView.backgroundColor = .systemOrange
        weatherForecastView.backgroundColor = .systemGreen
        
        bottomButtonView.backgroundColor = .systemGray5
    }
}
