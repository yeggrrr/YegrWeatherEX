//
//  WeatherView.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit

final class WeatherView: BaseView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let bottomButtonView = UIView()
    let mapButton = UIButton(type: .system)
    let detailButton = UIButton(type: .system)
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(bottomButtonView)
        bottomButtonView.addSubview(mapButton)
        bottomButtonView.addSubview(detailButton)
    }
    
    override func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeArea)
            $0.bottom.equalTo(bottomButtonView.snp.top)
        }
        
        bottomButtonView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalTo(safeArea)
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
    
    override func configureUI() {
        mapButton.setImage(UIImage(systemName: "map"), for: .normal)
        mapButton.tintColor = .white
        
        detailButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        detailButton.tintColor = .white
    }
}
