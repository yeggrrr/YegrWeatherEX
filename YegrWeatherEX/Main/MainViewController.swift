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
    }

    override func configureHierarchy() {
        view.addSubview(mainView)
    }
    
    override func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        mainView.snp.makeConstraints {
            $0.verticalEdges.equalTo(view)
            $0.horizontalEdges.equalTo(safeArea)
        }
    }
    
    override func configureUI() {
        view.backgroundColor = .white
        
        mainView.weatherCollectionView.delegate = self
        mainView.weatherCollectionView.dataSource = self
        mainView.weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.id)
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


