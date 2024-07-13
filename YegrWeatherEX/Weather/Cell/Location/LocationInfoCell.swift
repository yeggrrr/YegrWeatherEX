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
    
    var locationStatus: CLAuthorizationStatus?
    var mycoordinate: CLLocationCoordinate2D?
    
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
        titleLabel.setUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .semibold))
        configureLocation()
    }
    
    func createAnnotaion(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
    }
    
    func configureLocation() {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    func sesacLocation() {
        let sesacLocation = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
        mapView.region = MKCoordinateRegion(center: sesacLocation, latitudinalMeters: 300, longitudinalMeters: 300)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = sesacLocation
        annotation.title = "SeSAC 영등포 캠퍼스"
        mapView.addAnnotation(annotation)
    }
}

extension LocationInfoCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        let identifier = "Custom"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            // 재사용 가능한 식별자를 갖고 어노테이션 뷰를 생성
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            // 콜아웃 버튼을 보이게 함
            annotationView?.canShowCallout = true
            // 이미지 변경
            annotationView?.image = UIImage(systemName: "star.fill")
            
            // 상세 버튼 생성 후 액세서리에 추가 (i 모양 버튼)
            // 버튼을 만들어주면 callout 부분 전체가 버튼 역활을 합니다
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        }
        
        return annotationView
    }
}
