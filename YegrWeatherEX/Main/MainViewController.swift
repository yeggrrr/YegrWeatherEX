//
//  MainController.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/10/24.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAction()
    }

    override func configureHierarchy() {
        view.addSubview(mainView)
    }
    
    override func configureLayout() {
        mainView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    override func configureUI() {
        // view
        mainView.backgroundColor = .darkGray
        view.backgroundColor = .darkGray
        
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
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.id, for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
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
        return cell
    }
    
    
}


