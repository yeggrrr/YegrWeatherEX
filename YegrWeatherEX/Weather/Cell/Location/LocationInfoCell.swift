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

class LocationInfoCell: BaseCollectionViewCell {
    let titleLabel = UILabel()
    let mapView = MKMapView()
    
    var mycoordinate: CLLocationCoordinate2D?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createAnnotaion(title: "Seoul", subtitle: "", coordinate: CLLocationCoordinate2D(latitude: 37.56826, longitude: 126.977829))
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(mapView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalTo(mapView.snp.top).inset(-10)
        }
        
        mapView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    override func configureUI() {
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
