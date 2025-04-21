//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Егор Голубев on 21.04.2025.
//

import Foundation
import UIKit

protocol MainCoordinator: AnyObject {
    var childCoordinators: [MainCoordinator] {get set}
    func start()
}

extension MainCoordinator {
    
    func addChild(_ coordinator: MainCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: MainCoordinator) {
        guard let indexArray = childCoordinators.firstIndex(where: {$0 === coordinator}) else { return }
        childCoordinators.remove(at: indexArray)
    }
    
}
