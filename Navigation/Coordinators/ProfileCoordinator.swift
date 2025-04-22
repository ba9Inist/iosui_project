//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Егор Голубев on 21.04.2025.
//

import Foundation
import UIKit

class ProfileCoordinator: MainCoordinator {
    
    var childCoordinators: [MainCoordinator] = []
    let navigatorController: UINavigationController
    var tabBarController: UITabBarController?
    
    init() {
        self.navigatorController = UINavigationController()
    }
    
    func start() {
        
        let loginInspector = MyLoginFactory().makeLoginInspector()
        let loginVC = LoginViewController(loginInspector: loginInspector, coordinator:  self)
        navigatorController.viewControllers = [loginVC]
        
    }
        
    func showPhotos() {
        let photoVC = PhotosViewController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let tabBar = window.rootViewController as? UITabBarController {
            if let profileVC = tabBar.viewControllers?.first(where: {$0 is UINavigationController}) as? UINavigationController {
                profileVC.pushViewController(photoVC, animated: true)
            }
        }
    }
    
    func showProfile(user: User) {
        let tabBar = UITabBarController()
        let feedCoordinator = FeedCoordinator()
        feedCoordinator.setup()
        
        let profileVC = ProfileViewController(user: user)
        profileVC.coordinator = self
        
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"),tag: 0)
        let feedNC = feedCoordinator.feedNC
        feedNC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.bullet"), tag: 1)
        
        tabBar.viewControllers = [profileNav, feedNC]
        tabBar.selectedIndex = 0
        self.tabBarController = tabBar
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
    
    
    
    
}
