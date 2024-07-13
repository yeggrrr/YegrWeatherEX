//
//  MainController.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/10/24.
//

import UIKit
import SnapKit
import Shift
import Kingfisher

final class MainViewController: BaseViewController {
    let mainViewModel = MainViewModel()
    
    let backgroundImageView = UIImageView()
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        configureView()
        configureAction()
    }
    
    func bindData() {
        mainViewModel.inputViewDidLoadTrigger.value = ()
        mainViewModel.outputWeatherData.bind { weatherData in
            self.setCurrentData(data: weatherData)
        }
        
        mainViewModel.outputThreeDaysData.bind { _ in
            self.mainView.weatherCollectionView.reloadData()
        }
        
        mainViewModel.outputTotalWeatherData.bind { _ in
            self.mainView.weatherTableView.reloadData()
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainView)
    }
    
    override func configureLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configureUI() {
        backgroundImageView.image = UIImage(named: "weatherBackground")
    }
    
    func configureView() {
        // weatherCollectionView
        mainView.weatherCollectionView.delegate = self
        mainView.weatherCollectionView.dataSource = self
        mainView.weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
        
        // weatherTableView
        mainView.weatherTableView.delegate = self
        mainView.weatherTableView.dataSource = self
        mainView.weatherTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.id)
    }
    
    func configureAction() {
        mainView.mapButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
        mainView.detailButton.addTarget(self, action: #selector(detailButtonClicked), for: .touchUpInside)
    }
    
    func setCurrentData(data: CurrentWeatherData?) {
        guard let data = data else { return }
        guard let firstWeather = data.weather.first else { return }
        self.mainView.locationLabel.text = data.name
        self.mainView.currentTempLabel.text = " \(Int(data.main.temp))º"
        self.mainView.currentWeatherLabel.text = firstWeather.description
        self.mainView.highestTempLabel.text = "최고: \(Int(data.main.tempMax))º"
        self.mainView.lowestTempLabel.text = "최저: \(Int(data.main.tempMin))º"
        self.mainView.dividerLabel.text = "|"
    }
    
    @objc func mapButtonClicked() {
        print(#function)
    }
    
    @objc func detailButtonClicked() {
        print(#function)
        let vc = SearchCityViewController()
        vc.shift.enable()
        present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainViewModel.outputThreeDaysData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        let item = mainViewModel.outputThreeDaysData.value[indexPath.item]
        cell.setImage(iconName: item.weather.first?.icon)
        cell.tempLabel.text = "\(Int(item.main.temp))º"
        cell.timeLabel.text = DateFormatter.longToOnlyHour(dateString: item.dateText)
        return cell
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.outputTotalWeatherData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.id, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        if let day = mainViewModel.outputTotalWeatherData.value[indexPath.row].first {
            cell.lowestTempLabel.text = "최저 \(Int(day.main.tempMin))º"
            cell.highestTempLabel.text = "최고 \(Int(day.main.tempMax))º"
            cell.setImage(iconName: day.weather.first?.icon)
            
            if DateFormatter.longToShortDate(dateString: day.dateText) == DateFormatter.onlyDateFormatter.string(from: Date()) {
                cell.dateLabel.text = "오늘"
            } else {
                cell.dateLabel.text = DateFormatter.DateTodayOfWeek(dateString: day.dateText)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


