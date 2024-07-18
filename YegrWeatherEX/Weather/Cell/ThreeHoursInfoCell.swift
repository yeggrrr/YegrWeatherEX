//
//  ThreeHoursInfoCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit

final class ThreeHoursInfoCell: BaseCollectionViewCell {
    let threeHoursInfoCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    
    var outputThreeDaysData: [ThreeHoursFiveDaysWeatherData.List] = []
   
    override func configureHierarchy() {
        contentView.addSubview(threeHoursInfoCollectionView)
    }
    
    override func configureLayout() {
        threeHoursInfoCollectionView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configureUI() {
        threeHoursInfoCollectionView.delegate = self
        threeHoursInfoCollectionView.dataSource = self
        threeHoursInfoCollectionView.register(ThreeHoursInfoInnerCell.self, forCellWithReuseIdentifier: ThreeHoursInfoInnerCell.id)
        threeHoursInfoCollectionView.backgroundColor = .clear
        threeHoursInfoCollectionView.showsHorizontalScrollIndicator = false
    }
}

extension ThreeHoursInfoCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return outputThreeDaysData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeHoursInfoInnerCell.id, for: indexPath) as? ThreeHoursInfoInnerCell else { return UICollectionViewCell() }
        let item = outputThreeDaysData[indexPath.item]
        cell.setImage(iconName: item.weather.first?.icon)
        cell.tempLabel.text = "\(Int(item.main.temp))º"
        cell.timeLabel.text = DateFormatter.longToOnlyHour(dateString: item.dateText)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 5
        let size = CGSize(width: width, height: 150)
        return size
    }
}
