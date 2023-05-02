//
//  MainCoordinator.swift
//  MapApp
//
//  Created by Adilet on 27/4/23.
//

import UIKit

class MainCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    
    func start() {
        let vc = MapViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
