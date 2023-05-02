//
//  ViewController.swift
//  MapApp
//
//  Created by Adilet on 27/4/23.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {

    var coordinator: MainCoordinator?
    
    let locationManager = CLLocationManager()
    
    private lazy var mapView: MKMapView = {
        let m = MKMapView()
        m.overrideUserInterfaceStyle = .dark
        return m
    }()
    
    private lazy var findMe : UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "location.fill"), for: .normal)
        btn.layer.cornerRadius = 15
        btn.tintColor = .black
        btn.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        btn.addTarget(self, action: #selector(updateCL), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    func checkLocationEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            setupManager()
            checkAuthorization()
        }
        else {
            showAlertLocation(title: "Your location manager is turned off", message: "Do you want to turn it on?", url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
        }
        
    }
    
    func setupManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            showAlertLocation(title: "You decided to turn off location manager", message: "Change?", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        }}
    
    func showAlertLocation(title: String, message: String?, url: URL?){
        
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Options", style: .default) { (alert) in
                if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES"){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(settingsAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        
    }
    @objc func updateCL(){
//        self.mapView.setCenter(self.mapView.userLocation.coordinate, animated: true)
        self.mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    
    private func setupTileRenderer() {
      // 1
      let template = "https://tile.openstreetmap.org/{z}/{x}/{y}.png"

      // 2
      let overlay = MKTileOverlay(urlTemplate: template)

      // 3
      overlay.canReplaceMapContent = true

      // 4
      mapView.addOverlay(overlay, level: .aboveLabels)

      //5
      tileRenderer = MKTileOverlayRenderer(tileOverlay: overlay)
    }


}


extension MapViewController: CLLocationManagerDelegate{
    func setupSubviews() {
        view .addSubview(mapView)
        view.addSubview(findMe)
    }
    
    

    func setupConstraints() {
        mapView.snp.makeConstraints{make in
            make.top.left.right.bottom.equalToSuperview()
        }
        findMe.snp.makeConstraints{make in
            make.right.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(100)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if let location = locations.first?.coordinate{
//            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
//            mapView.setRegion(region, animated: true)
//        }
//    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
}

