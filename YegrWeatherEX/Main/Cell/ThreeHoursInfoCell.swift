//
//  ThreeHoursInfoCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit

class ThreeHoursInfoCell: BaseCollectionViewCell {
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
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        backgroundColor = .systemCyan
        
        threeHoursInfoCollectionView.delegate = self
        threeHoursInfoCollectionView.dataSource = self
        threeHoursInfoCollectionView.register(ThreeHoursInfoInnerCell.self, forCellWithReuseIdentifier: ThreeHoursInfoInnerCell.id)
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





class ThreeHoursInfoInnerCell: BaseCollectionViewCell {
    let timeLabel = UILabel()
    let weatherImage = UIImageView()
    let tempLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(tempLabel)
    }
    
    override func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(10)
            $0.horizontalEdges.equalTo(safeArea.snp.horizontalEdges).inset(10)
            $0.height.equalTo(30)
        }
        
        weatherImage.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(timeLabel.snp.centerX)
            $0.height.width.equalTo(40)
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(weatherImage.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeArea.snp.horizontalEdges).inset(10)
            $0.bottom.equalTo(safeArea).offset(-10)
        }
    }
    
    override func configureUI() {
        backgroundColor = .red
        
        timeLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 17, weight: .regular))
        tempLabel.setUI(txtColor: .white, txtAlignment: .center, fontStyle: .systemFont(ofSize: 17, weight: .regular))
    }
    
    func setImage(iconName: String?) {
        guard let iconName = iconName else { return }
        let imageURL = URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")
        weatherImage.kf.setImage(with: imageURL)
    }
}
