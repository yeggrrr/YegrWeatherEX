//
//  MapView.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/15/24.
//

import UIKit
import SnapKit
import MapKit

final class MapView: UIView {
    private let backgroundImage = UIImageView()
    let myLocationButton = UIButton(type: .system)
    let xButton = UIButton(type: .system)
    let mapview = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(backgroundImage)
        addSubview(myLocationButton)
        addSubview(xButton)
        addSubview(mapview)
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        myLocationButton.snp.makeConstraints {
            $0.top.leading.equalTo(safeArea).inset(20)
            $0.height.width.equalTo(30)
        }
        
        xButton.snp.makeConstraints {
            $0.top.trailing.equalTo(safeArea).inset(20)
            $0.height.width.equalTo(30)
        }
        
        mapview.snp.makeConstraints {
            $0.top.equalTo(xButton.snp.bottom).offset(10)
            $0.bottom.horizontalEdges.equalTo(safeArea).inset(20)
        }
    }
    
    private func configureUI() {
        backgroundImage.image = UIImage(named: "weatherBackgroundDark")
        
        myLocationButton.setImage(UIImage(systemName: "location"), for: .normal)
        myLocationButton.tintColor = .white
        
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.tintColor = .white
        
        mapview.layer.cornerRadius = 10
    }
}
