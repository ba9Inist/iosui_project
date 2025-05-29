//
//  TabBarVC.swift
//  Navigation
//
//  Created by Егор Голубев on 28.05.2025.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let directoryVC = DirectoryVC()
        let settingsVC = SettingsVC()

        settingsVC.delegate = directoryVC

        let directoryNC = UINavigationController(rootViewController: directoryVC)
        let settingsNC = UINavigationController(rootViewController: settingsVC)

        directoryNC.tabBarItem.image = UIImage(systemName: "camera")
        settingsNC.tabBarItem.image = UIImage(systemName: "gear")
        
        self.viewControllers = [directoryNC, settingsNC]
    }
}
