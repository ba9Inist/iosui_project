//
//  CustomAlert.swift
//  Navigation
//
//  Created by Егор Голубев on 28.05.2025.
//

import Foundation
import UIKit

final class customAlert {
    
    func setubAlert (title: String, sms: String, type: UIAlertController.Style, buttonAlert: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title, message: sms, preferredStyle: type)
        
        if buttonAlert.isEmpty {
            alert.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            for action in buttonAlert {
                alert.addAction(action)
            }
        }
        
        findTopMostViewController()?.present(alert, animated: true, completion: nil)
    }
    
    private func findTopMostViewController() -> UIViewController? {
        guard let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else { return nil }
        
        var topController = rootViewController
        
        while let presentedController = topController.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
}
