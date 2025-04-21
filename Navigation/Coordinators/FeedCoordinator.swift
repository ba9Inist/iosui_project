//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Егор Голубев on 21.04.2025.
//

import Foundation
import UIKit

class FeedCoordinator: MainCoordinator {
    
    var childCoordinators: [MainCoordinator] = []
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let feedVC = FeedViewController()
        feedVC.coordinator = self
        navigationController.viewControllers = [feedVC]
    }
    
    func showPost(with post: Post) {
        let postVC = PostViewController()
        navigationController.pushViewController(postVC, animated: true)
    }
    
}
