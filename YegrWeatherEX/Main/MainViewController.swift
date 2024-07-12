//
//  MainController.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/10/24.
//

import UIKit
import SnapKit
import Shift

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
            guard let weatherData = weatherData else { return }
            self.mainView.locationLabel.text = weatherData.name
            self.mainView.currentTempLabel.text = " \(Int(weatherData.main.temp))º"
            self.mainView.currentWeatherLabel.text = weatherData.weather.first?.description
            self.mainView.highestTempLabel.text = "최고: \(Int(weatherData.main.temp_max))º"
            self.mainView.lowestTempLabel.text = "최저: \(Int(weatherData.main.temp_min))º"
            self.mainView.dividerLabel.text = "|"
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
    
    @objc func mapButtonClicked() {
        print(#function)
    }
    
    @objc func detailButtonClicked() {
        print(#function)
        let vc = SearchViewController()
        vc.shift.enable()
        present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .clear
        return cell
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.id, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


