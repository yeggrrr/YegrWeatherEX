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
    
    let tempStackView = UIStackView()
    let highestTempLabel = UILabel()
    let dividerLabel = UILabel()
    let lowestTempLabel = UILabel()
    
    private let everyThreeHoursView = UIView()
    let everyThreeHoursImageView = UIImageView()
    let everyThreeHoursLabel = UILabel()
    let weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: threeDaysCollectionViewLayout())
    
    private let weatherForecastView = UIView()
    let fiveDaysImage = UIImageView()
    let fiveDaysLabel = UILabel()
    let weatherTableView = UITableView()
    
    private let additionalInfoView = UIView()
    let additionalInfoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: additionalInfoCollecionViewLayout())
    
    private let bottomButtonView = UIView()
    let mapButton = UIButton(type: .system)
    let detailButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureTopLayout()
        configureCenterLayout()
        configureBottomLayout()
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
        
        topTitleView.addSubview(tempStackView)
        tempStackView.addArrangedSubview(highestTempLabel)
        tempStackView.addArrangedSubview(dividerLabel)
        tempStackView.addArrangedSubview(lowestTempLabel)
        
        backgroundView.addSubview(everyThreeHoursView)
        everyThreeHoursView.addSubview(everyThreeHoursImageView)
        everyThreeHoursView.addSubview(everyThreeHoursLabel)
        everyThreeHoursView.addSubview(weatherCollectionView)
        
        backgroundView.addSubview(weatherForecastView)
        weatherForecastView.addSubview(fiveDaysImage)
        weatherForecastView.addSubview(fiveDaysLabel)
        weatherForecastView.addSubview(weatherTableView)
        
        backgroundView.addSubview(additionalInfoView)
        additionalInfoView.addSubview(additionalInfoCollectionView)
        
        addSubview(bottomButtonView)
        bottomButtonView.addSubview(mapButton)
        bottomButtonView.addSubview(detailButton)
    }
    
    func configureTopLayout() {
        let safeArea = safeAreaLayoutGuide
        let scrollViewContent = scrollView.contentLayoutGuide
        let scrollViewFrame = scrollView.frameLayoutGuide
        
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeArea)
            $0.bottom.equalTo(bottomButtonView.snp.top)
        }
        
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
            $0.height.equalTo(50)
        }
        
        currentTempLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom)
            $0.horizontalEdges.equalTo(topTitleView.snp.horizontalEdges).inset(20)
            $0.height.equalTo(100)
        }
        
        currentWeatherLabel.snp.makeConstraints {
            $0.top.equalTo(currentTempLabel.snp.bottom)
            $0.horizontalEdges.equalTo(topTitleView.snp.horizontalEdges).inset(20)
            $0.height.equalTo(35)
        }
        
        tempStackView.snp.makeConstraints {
            $0.top.equalTo(currentWeatherLabel.snp.bottom)
            $0.horizontalEdges.equalTo(topTitleView.snp.horizontalEdges).inset(20)
            $0.height.equalTo(35)
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
    
    func configureCenterLayout() {
        everyThreeHoursView.snp.makeConstraints {
            $0.top.equalTo(topTitleView.snp.bottom)
            $0.horizontalEdges.equalTo(backgroundView.snp.horizontalEdges)
            $0.height.equalTo(180)
        }
        
        everyThreeHoursImageView.snp.makeConstraints {
            $0.top.equalTo(everyThreeHoursView.snp.top).offset(5)
            $0.leading.equalTo(everyThreeHoursView.snp.leading).offset(20)
            $0.height.width.equalTo(20)
        }
        
        everyThreeHoursLabel.snp.makeConstraints {
            $0.top.equalTo(everyThreeHoursView.snp.top).offset(5)
            $0.leading.equalTo(everyThreeHoursImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(everyThreeHoursView.snp.trailing).offset(20)
            $0.height.equalTo(20)
        }
        
        weatherCollectionView.snp.makeConstraints {
            $0.top.equalTo(everyThreeHoursLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(everyThreeHoursView.snp.horizontalEdges).inset(10)
            $0.bottom.equalTo(everyThreeHoursView.snp.bottom)
        }
        
        weatherForecastView.snp.makeConstraints {
            $0.top.equalTo(everyThreeHoursView.snp.bottom)
            $0.horizontalEdges.equalTo(backgroundView.snp.horizontalEdges)
            $0.height.equalTo(320)
        }
        
        fiveDaysImage.snp.makeConstraints {
            $0.top.equalTo(weatherForecastView.snp.top).offset(5)
            $0.leading.equalTo(weatherForecastView.snp.leading).offset(20)
            $0.height.width.equalTo(20)
        }
        
        fiveDaysLabel.snp.makeConstraints {
            $0.top.equalTo(weatherForecastView.snp.top).offset(5)
            $0.leading.equalTo(fiveDaysImage.snp.trailing).offset(10)
            $0.trailing.equalTo(weatherForecastView.snp.trailing).offset(-10)
            $0.height.equalTo(20)
        }
        
        weatherTableView.snp.makeConstraints {
            $0.top.equalTo(fiveDaysLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(weatherForecastView.snp.horizontalEdges)
            $0.bottom.equalTo(weatherForecastView.snp.bottom)
        }
    }
    
    func configureBottomLayout() {
        let safeArea = safeAreaLayoutGuide
        
        additionalInfoView.snp.makeConstraints {
            $0.top.equalTo(weatherForecastView.snp.bottom)
            $0.horizontalEdges.equalTo(backgroundView.snp.horizontalEdges)
            $0.bottom.equalTo(backgroundView.snp.bottom)
            $0.height.equalTo(additionalInfoView.snp.width)
        }
        
        additionalInfoCollectionView.snp.makeConstraints {
            $0.top.equalTo(additionalInfoView.snp.top).offset(10)
            $0.horizontalEdges.equalTo(additionalInfoView.snp.horizontalEdges).inset(10)
            $0.bottom.equalTo(additionalInfoView.snp.bottom).offset(-10)
        }
        
        bottomButtonView.snp.makeConstraints {
            $0.bottom.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(60)
        }
        
        mapButton.snp.makeConstraints {
            $0.leading.equalTo(bottomButtonView.snp.leading).offset(10)
            $0.centerY.equalTo(bottomButtonView.snp.centerY)
            $0.width.height.equalTo(40)
        }
        
        detailButton.snp.makeConstraints {
            $0.trailing.equalTo(bottomButtonView.snp.trailing).offset(-10)
            $0.centerY.equalTo(bottomButtonView.snp.centerY)
            $0.width.height.equalTo(40)
        }
    }
    
    func configureUI() {
        everyThreeHoursLabel.text = "3시간 간격의 일기예보"
        fiveDaysLabel.text = "5일 간의 일기예보"
        
        locationLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 40, weight: .regular))
        currentTempLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 80, weight: .thin))
        currentWeatherLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 20, weight: .regular))
        
        tempStackView.axis = .horizontal
        tempStackView.spacing = 10
        tempStackView.alignment = .center
        tempStackView.distribution = .fillProportionally
        highestTempLabel.setUI(txtColor: .white, txtAlignment: .right, fontStyle: .systemFont(ofSize: 20, weight: .regular))
        lowestTempLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 20, weight: .regular))
        dividerLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 20, weight: .semibold))
        
        // weatherCollectionView
        weatherCollectionView.backgroundColor = .clear
        weatherCollectionView.showsHorizontalScrollIndicator = false
        
        // everyThreeHours
        everyThreeHoursImageView.image = UIImage(systemName: "calendar")
        everyThreeHoursImageView.tintColor = .white
        everyThreeHoursLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .regular))
        
        fiveDaysImage.image = UIImage(systemName: "calendar")
        fiveDaysImage.tintColor = .white
        fiveDaysLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .regular))
        
        // weatherTableView
        weatherTableView.backgroundColor = .clear
        weatherTableView.showsVerticalScrollIndicator = false
        
        additionalInfoView.backgroundColor = .systemGray
        additionalInfoCollectionView.backgroundColor = .white
        
        // bottomButtons
        mapButton.setImage(UIImage(systemName: "map"), for: .normal)
        detailButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        mapButton.tintColor = .white
        detailButton.tintColor = .white
    }
    
    static func threeDaysCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width / 5, height: 150)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    static func additionalInfoCollecionViewLayout() -> UICollectionViewLayout {
        let layout  = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - (10 * 2) - (10 * 2) + 10
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}
