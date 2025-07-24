//
//  AppDelegate.swift
//  Navigation
//

import UIKit
import Firebase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let navController = UINavigationController(rootViewController: GeoMapVC())
        window.rootViewController = navController
        window.makeKeyAndVisible()
//        appCoordinator = AppCoordinator(window: window)
//        appCoordinator?.start()
        FirebaseApp.configure()
        
        LocalNotificationsService.shared.checkAccess()
        
        return true
        
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out:", error.localizedDescription)
        }
    }
}

