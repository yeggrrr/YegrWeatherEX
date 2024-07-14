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

class MapViewController: BaseViewController {
    let backgroundImage = UIImageView()
    let xButton = UIButton(type: .system)
    let mapview = MKMapView()
    let locationManager = CLLocationManager()
    
    var locationStatus: CLAuthorizationStatus?
    var mycoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocation()
    }
    
    override func configureHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(xButton)
        view.addSubview(mapview)
    }
    
    override func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
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
    
    override func configureUI() {
        backgroundImage.image = UIImage(named: "weatherBackgroundDark")
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.tintColor = .white
        xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        
        mapview.layer.cornerRadius = 10
    }
    
    func configureLocation() {
        locationManager.delegate = self
        mapview.showsUserLocation = true
        mapview.setUserTrackingMode(.follow, animated: true)
    }
    
    func setLocation(latitude: Double, longitude: Double, name: String ) {
        let currentLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapview.region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 400, longitudinalMeters: 400)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation
        annotation.title = "\(name)"
        mapview.addAnnotation(annotation)
    }
    
    @objc func xButtonClicked() {
        dismiss(animated: true)
    }
}

extension MapViewController {
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.checkCurrentLocationAuthorization()
            } else {
                self.alert(title: "위치 서비스가 꺼져 있어서, 위치 권한을 요청할 수 없습니다.", message: "", cancelHandler: UIAlertAction(title: "취소", style: .cancel), okHandler: UIAlertAction(title: "설정으로 이동", style: .default, handler: { _ in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
            }
        }
    }
    
    func checkCurrentLocationAuthorization() {
        if #available(iOS 14.0, *) {
            locationStatus = locationManager.authorizationStatus
        } else {
            locationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch locationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            setLocation(latitude: 37.517742, longitude: 126.886463, name: "SeSAC 영등포 캠퍼스")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print(#function)
        }
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 300, longitudinalMeters: 300)
        mapview.setRegion(region, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            print(">>> \(coordinate.latitude), \(coordinate.longitude)")
            setRegionAndAnnotation(center: coordinate)
            mycoordinate = coordinate
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function, "iOS14+")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "iOS14-")
        checkDeviceLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, "iOS14+")
    }
}
