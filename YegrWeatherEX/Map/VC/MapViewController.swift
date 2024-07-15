//
//  MapViewController.swift
//  YegrWeatherEX
//
//  Created by YJ on 7/14/24.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

final class MapViewController: BaseViewController {
    private let mapView = MapView()
    
    private let locationManager = CLLocationManager()
    
    private var locationStatus: CLAuthorizationStatus?
    private var mycoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(mapView)
    }
    
    override func configureLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configureUI() {
        mapView.myLocationButton.addTarget(self, action: #selector(myLocationButtonClicked), for: .touchUpInside)
        mapView.xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        locationManager.delegate = self
    }
    
    private func setLocation(latitude: Double, longitude: Double, name: String ) {
        let currentLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        
        self.mapView.mapview.region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 200, longitudinalMeters: 200)
        annotation.coordinate = currentLocation
        annotation.title = "\(name)"
        self.mapView.mapview.addAnnotation(annotation)
    }
    
    @objc func xButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func myLocationButtonClicked()  {
        guard let locationStatus = locationStatus else { return }
        switch locationStatus {
        case .notDetermined, .restricted, .denied:
            alert(
                title: "위치 서비스를 사용할 수 없습니다.",
                message: "'설정 > 개인정보 보호'에서\n위치 서비스를 켜주세요.(필수권한)",
                cancelHandler: UIAlertAction(title: "취소", style: .cancel),
                okHandler: UIAlertAction( title: "설정으로 이동", style: .default) { _ in
                    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                    UIApplication.shared.open(url)
                }
            )
        default:
            guard let mycoordinate = mycoordinate else { return }
            setRegionAndAnnotation(center: mycoordinate)
        }
    }
}

extension MapViewController {
    func checkCurrentLocationAuthorization() {
        if #available(iOS 14.0, *) {
            locationStatus = locationManager.authorizationStatus
        } else {
            locationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch self.locationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            self.mapView.mapview.showsUserLocation = true
        case .notDetermined:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
        case .denied:
            self.setLocation(latitude: 37.517742, longitude: 126.886463, name: "SeSAC 영등포 캠퍼스")
        default:
            break
        }
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
        self.mapView.mapview.setRegion(region, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            self.setRegionAndAnnotation(center: coordinate)
            self.mycoordinate = coordinate
        }
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function, "iOS14+")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "iOS14-")
        checkCurrentLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, "iOS14+")
    }
}
