//
//  AppCoorfinator.swift
//  Navigation
//
//  Created by Егор Голубев on 21.04.2025.
//

import Foundation
import UIKit

class AppCoordinator: MainCoordinator {

    var childCoordinators: [MainCoordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.start()
        window.rootViewController = profileCoordinator.navigatorController
        window.makeKeyAndVisible()
        
    }
    
}
