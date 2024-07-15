//
//  MapView.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/15/24.
//

import UIKit
import SnapKit
import MapKit

class MapView: UIView {
    let backgroundImage = UIImageView()
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
    
    func configureHierarchy() {
        addSubview(backgroundImage)
        addSubview(xButton)
        addSubview(mapview)
    }
    
    func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        xButton.snp.makeConstraints {
            $0.top.trailing.equalTo(safeArea).inset(10)
            $0.height.width.equalTo(30)
        }
        
        mapview.snp.makeConstraints {
            $0.top.equalTo(xButton.snp.bottom).offset(10)
            $0.bottom.horizontalEdges.equalTo(safeArea).inset(20)
        }
    }
    
    func configureUI() {
        backgroundImage.image = UIImage(named: "weatherBackgroundDark")
        
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.tintColor = .white
        
        mapview.layer.cornerRadius = 10
    }
}
