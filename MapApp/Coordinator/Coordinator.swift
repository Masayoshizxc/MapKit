//
//  Coordinator.swift
//  MapApp
//
//  Created by Adilet on 27/4/23.
//

import UIKit

protocol Coordinator {
    
    var parentCoordinator: Coordinator? { get set }
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
