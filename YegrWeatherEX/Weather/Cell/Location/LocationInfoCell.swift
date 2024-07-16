//
//  LocationInfoCell.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/13/24.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

final class LocationInfoCell: BaseCollectionViewCell {
    private let iconImage = UIImageView()
    let titleLabel = UILabel()
    private let mapView = MKMapView()
    
    private var mycoordinate: CLLocationCoordinate2D?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createAnnotaion(title: "Seoul", subtitle: "", coordinate: CLLocationCoordinate2D(latitude: 37.56826, longitude: 126.977829))
    }
    
    override func configureHierarchy() {
        contentView.addSubview(iconImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(mapView)
    }
    
    override func configureLayout() {
        iconImage.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.leading.equalToSuperview().offset(10)
            $0.height.width.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(iconImage.snp.trailing).offset(5)
            $0.bottom.equalTo(mapView.snp.top).inset(-10)
        }
        
        mapView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    override func configureUI() {
        iconImage.image = UIImage(systemName: "location.circle.fill")
        iconImage.tintColor = .white
        
        titleLabel.text = "위치"
        titleLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .bold))
        
        mapView.layer.cornerRadius = 10
    }
    
    func createAnnotaion(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        mapView.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
    }
}
