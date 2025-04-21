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
    
    func showProfile (for user: User) {
        
        let profileVC = ProfileViewController(user: user)
        profileVC.coordinator = self
        navigatorController.pushViewController(profileVC, animated: true)
        
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
    
    func showTabs(user: User) {
        let tabBar = UITabBarController()
        let feedCoordinator = FeedCoordinator()
        feedCoordinator.start()
        
        let profileVC = ProfileViewController(user: user)
        profileVC.coordinator = self
        
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"),tag: 0)
        let feedNav = feedCoordinator.navigationController
        feedNav.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.bullet"), tag: 1)
        
        tabBar.viewControllers = [profileNav, feedNav]
        tabBar.selectedIndex = 0
        self.tabBarController = tabBar
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
    
    
    
    
}
