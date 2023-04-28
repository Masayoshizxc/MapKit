//
//  ViewController.swift
//  MapApp
//
//  Created by Adilet on 27/4/23.
//

import UIKit
import MapKit


class MapView: UIViewController {

    var coordinator: MainCoordinator?
    
    private lazy var map: MKMapView = {
        let m = MKMapView()
        m.overrideUserInterfaceStyle = .dark
        return m
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension MapView {
    func setupSubviews() {
        view .addSubview(map)
    }
    
    func setupConstraints() {
        
    }
}
