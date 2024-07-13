//
//  WeatherViewController.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit

class WeatherViewController: BaseViewController {
    enum SectionType {
        case currentInfo
        case threeHoursInfo
        case fiveDaysInfo
        case locationInfo
        case etcInfo
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let sectionList: [SectionType] = [.currentInfo, .threeHoursInfo, .fiveDaysInfo, .locationInfo, .etcInfo]
    
    let mainViewModel = MainViewModel()
    var currentInfoData: CurrentInfoData?
    var ectInfoDataList: [EtcInfoData] = []
    
    struct CurrentInfoData {
        let location: String
        let currentTemp: String
        let currentWeather: String
        let highestTemp: String
        let lowestTemp: String
        let divider: String
    }
    
    struct EtcInfoData {
        let title: String
        let description: String
        let firstDetailInfo: String
        let secondDetailInfo: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        bindData()
    }
    
    func bindData() {
        mainViewModel.inputViewDidLoadTrigger.value = ()
        mainViewModel.outputWeatherData.bind { weatherData in
            self.setCurrentData(data: weatherData)
            self.setEtcInfoData(data: weatherData)
        }
        
        mainViewModel.outputThreeDaysData.bind { _ in
            self.collectionView.reloadSections(IndexSet(integer: 1))
        }
        
        mainViewModel.outputTotalWeatherData.bind { _ in
            self.collectionView.reloadSections(IndexSet(integer: 2))
        }
    }
    
    func setCurrentData(data: CurrentWeatherData?) {
        guard let data = data else { return }
        guard let firstWeather = data.weather.first else { return }
        currentInfoData = CurrentInfoData(
            location: data.name,
            currentTemp: " \(Int(data.main.temp))º",
            currentWeather: firstWeather.description,
            highestTemp: "최고: \(Int(data.main.tempMax))º",
            lowestTemp: "최저: \(Int(data.main.tempMin))º",
            divider: "|")
        self.collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func setEtcInfoData(data: CurrentWeatherData?) {
        guard let data = data else { return }
        let windSpeed = EtcInfoData(
            title: "바람 속도",
            description: "\(data.wind.speed)m/s",
            firstDetailInfo: "",
            secondDetailInfo: "\(data.wind.deg)")
        
        let cloud = EtcInfoData(
            title: "구름",
            description: "\(data.clouds.all)%",
            firstDetailInfo: "",
            secondDetailInfo: "")
        
        let pressure = EtcInfoData(
            title: "기압",
            description: "\(Int(data.main.pressure))",
            firstDetailInfo: "hps",
            secondDetailInfo: "")
        
        let humidity = EtcInfoData(
            title: "습도",
            description: "\(Int(data.main.humidity))%",
            firstDetailInfo: "",
            secondDetailInfo: "")
        
        ectInfoDataList = [windSpeed, cloud, pressure, humidity]
        self.collectionView.reloadSections(IndexSet(integer: 4))
    }
    
    func configureCollectionView() {
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CurrentInfoCell.self, forCellWithReuseIdentifier: CurrentInfoCell.id)
        collectionView.register(ThreeHoursInfoCell.self, forCellWithReuseIdentifier: ThreeHoursInfoCell.id)
        collectionView.register(FiveDaysInfoCell.self, forCellWithReuseIdentifier: FiveDaysInfoCell.id)
        collectionView.register(LocationInfoCell.self, forCellWithReuseIdentifier: LocationInfoCell.id)
        collectionView.register(EtcInfoCell.self, forCellWithReuseIdentifier: EtcInfoCell.id)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sectionList[section] {
        case .currentInfo:
            return 1
        case .threeHoursInfo:
            return 1
        case .fiveDaysInfo:
            return mainViewModel.outputTotalWeatherData.value.count
        case .locationInfo:
            return 1
        case .etcInfo:
            return ectInfoDataList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sectionList[indexPath.section] {
        case .currentInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentInfoCell.id, for: indexPath) as? CurrentInfoCell else { return UICollectionViewCell() }
            guard let currentInfoData = currentInfoData else { return cell }
            cell.todayView.locationLabel.text = currentInfoData.location
            cell.todayView.currentTempLabel.text = currentInfoData.currentTemp
            cell.todayView.currentWeatherLabel.text = currentInfoData.currentWeather
            cell.todayView.highestTempLabel.text = currentInfoData.highestTemp
            cell.todayView.lowestTempLabel.text = currentInfoData.lowestTemp
            cell.todayView.dividerLabel.text = currentInfoData.divider
            return cell
        case .threeHoursInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeHoursInfoCell.id, for: indexPath) as? ThreeHoursInfoCell else { return UICollectionViewCell() }
            cell.outputThreeDaysData = mainViewModel.outputThreeDaysData.value
            return cell
        case .fiveDaysInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiveDaysInfoCell.id, for: indexPath) as? FiveDaysInfoCell else { return UICollectionViewCell() }
            guard let day = mainViewModel.outputTotalWeatherData.value[indexPath.item].first else { return cell }
            cell.lowestTempLabel.text = "최저 \(Int(day.main.tempMin))º"
            cell.highestTempLabel.text = "최고 \(Int(day.main.tempMax))º"
            cell.setImage(iconName: day.weather.first?.icon)
            
            let targetDate = DateFormatter.longToShortDate(dateString: day.dateText)
            let todayDate = DateFormatter.onlyDateFormatter.string(from: Date())
            let isToday = targetDate == todayDate
            cell.dateLabel.text = isToday ? "오늘" : DateFormatter.DateTodayOfWeek(dateString: day.dateText)
            return cell
        case .locationInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationInfoCell.id, for: indexPath) as? LocationInfoCell else { return UICollectionViewCell() }
            return cell
        case .etcInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EtcInfoCell.id, for: indexPath) as? EtcInfoCell else { return UICollectionViewCell() }
            let item = ectInfoDataList[indexPath.item]
            cell.titleLabel.text = item.title
            cell.descriptionLabel.text = item.description
            cell.firstDetailInfoLabel.text = item.firstDetailInfo
            cell.secondDetailInfoLabel.text = item.secondDetailInfo
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch sectionList[indexPath.section] {
        case .currentInfo:
            let width = collectionView.frame.width
            let size = CGSize(width: width, height: 350)
            return size
        case .threeHoursInfo:
            let width = collectionView.frame.width
            let size = CGSize(width: width, height: 150)
            return size
        case .fiveDaysInfo:
            let width = collectionView.frame.width
            let size = CGSize(width: width, height: 60)
            return size
        case .locationInfo:
            let width = collectionView.frame.width
            let size = CGSize(width: width, height: width)
            return size
        case .etcInfo:
            let width = (collectionView.frame.width - 15) / 2
            let size = CGSize(width: width, height: width)
            return size
        }
    }
}
