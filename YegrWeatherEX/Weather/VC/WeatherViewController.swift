//
//  WeatherViewController.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit
import Shift
import MapKit

class WeatherViewController: BaseViewController {
    let weatherViewModel = WeatherViewModel()
    
    let backgroundImage = UIImageView()
    let weatherView = WeatherView()
    
    let sectionList: [SectionType] = [.currentInfo, .threeHoursInfo, .fiveDaysInfo, .locationInfo, .etcInfo]
    
    var currentInfoData: CurrentInfoData?
    var ectInfoDataList: [EtcInfoData] = []
    var mycoordinate: CLLocationCoordinate2D?
    
    enum SectionType {
        case currentInfo
        case threeHoursInfo
        case fiveDaysInfo
        case locationInfo
        case etcInfo
    }
    
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
        
        bindData()
        configureCollectionView()
        configureUI()
        configureAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCityData()
    }
    
    override func configureHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(weatherView)
    }
    
    override func configureLayout() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        weatherView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configureUI() {
        weatherView.collectionView.backgroundColor = .clear
        backgroundImage.image = UIImage(named: "weatherBackground")
    }
    
    func bindData() {
        weatherViewModel.inputViewDidLoadTrigger.value = ()
        weatherViewModel.outputWeatherData.bind { weatherData in
            self.setCurrentData(data: weatherData)
            self.setEtcInfoData(data: weatherData)
        }
        
        weatherViewModel.outputThreeDaysData.bind { _ in
            self.weatherView.collectionView.reloadSections(IndexSet(integer: 1))
        }
        
        weatherViewModel.outputTotalWeatherData.bind { _ in
            self.weatherView.collectionView.reloadSections(IndexSet(integer: 2))
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
        self.weatherView.collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func setEtcInfoData(data: CurrentWeatherData?) {
        guard let data = data else { return }
        let windSpeed = EtcInfoData(
            title: "바람 속도",
            description: "\(data.wind.speed)m/s",
            firstDetailInfo: "",
            secondDetailInfo: "")
        
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
        self.weatherView.collectionView.reloadSections(IndexSet(integer: 4))
    }
    
    func getCityData() {
        guard let city = CityRepository.shared.fetch().first else { return }
        weatherViewModel.callRequest(id: city.cityId)
        self.weatherView.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
    }
    
    func configureCollectionView() {
        weatherView.collectionView.delegate = self
        weatherView.collectionView.dataSource = self
        weatherView.collectionView.register(CurrentInfoCell.self, forCellWithReuseIdentifier: CurrentInfoCell.id)
        weatherView.collectionView.register(ThreeHoursInfoCell.self, forCellWithReuseIdentifier: ThreeHoursInfoCell.id)
        weatherView.collectionView.register(FiveDaysInfoCell.self, forCellWithReuseIdentifier: FiveDaysInfoCell.id)
        weatherView.collectionView.register(LocationInfoCell.self, forCellWithReuseIdentifier: LocationInfoCell.id)
        weatherView.collectionView.register(EtcInfoCell.self, forCellWithReuseIdentifier: EtcInfoCell.id)
        weatherView.collectionView.register(WeatherSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeatherSectionHeaderView.id)
        
        weatherView.collectionView.showsVerticalScrollIndicator = false
    }
    
    func configureAction() {
        weatherView.mapButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
        weatherView.detailButton.addTarget(self, action: #selector(detailButtonClicked), for: .touchUpInside)
    }
    
    @objc func mapButtonClicked() {
        let vc = MapViewController()
        vc.shift.enable()
        present(vc, animated: true)
    }
    
    @objc func detailButtonClicked() {
        let vc = SearchCityViewController()
        vc.delegate = self
        vc.shift.enable()
        present(vc, animated: true)
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sectionList[section] {
        case .currentInfo, .threeHoursInfo, .locationInfo:
            return 1
        case .fiveDaysInfo:
            return weatherViewModel.outputTotalWeatherData.value.count
        case .etcInfo:
            return ectInfoDataList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WeatherSectionHeaderView.id, for: indexPath) as? WeatherSectionHeaderView else { return UICollectionReusableView() }
            switch sectionList[indexPath.section] {
            case .threeHoursInfo:
                headerView.titleLabel.text = "3시간 간격의 일기예보"
                headerView.iconImage.isHidden = false
            case .fiveDaysInfo:
                headerView.titleLabel.text = "5일간의 일기예보"
                headerView.iconImage.isHidden = false
            default:
                headerView.titleLabel.text = ""
                headerView.iconImage.isHidden = true
                break
            }
            return headerView
        default:
            return UICollectionReusableView()
        } 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        
        switch sectionList[section] {
        case .threeHoursInfo, .fiveDaysInfo:
            return CGSize(width: width, height: 40)
        case .etcInfo, .locationInfo:
            return CGSize(width: width, height: 20)
        default:
            return CGSize(width: width, height: 0)
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
            cell.outputThreeDaysData = weatherViewModel.outputThreeDaysData.value
            cell.threeHoursInfoCollectionView.reloadData()
            return cell
        case .fiveDaysInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiveDaysInfoCell.id, for: indexPath) as? FiveDaysInfoCell else { return UICollectionViewCell() }
            guard let day = weatherViewModel.outputTotalWeatherData.value[indexPath.item].first else { return cell }
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
            if let city = CityRepository.shared.fetch().first {
                cell.createAnnotaion(title: city.name, subtitle: city.country, coordinate: CLLocationCoordinate2D(latitude: city.coordLat, longitude: city.coordLon))
            }
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
            let size = CGSize(width: width, height: 350)
            return size
        case .etcInfo:
            let width = (collectionView.frame.width - 15) / 2
            let size = CGSize(width: width, height: width)
            return size
        }
    }
}

extension WeatherViewController: CityDelegate {
    func reloadCityInfo() {
        getCityData()
    }
}
