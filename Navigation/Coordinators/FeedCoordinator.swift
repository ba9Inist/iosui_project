//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Егор Голубев on 21.04.2025.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var controller: UIViewController { get set }
    var children: [Coordinator] { get set }
    
    func setup()
}


final class FeedCoordinator: Coordinator {
    var controller: UIViewController
    
    var children: [Coordinator]
    
    let feedVC = FeedViewController()
    let feedNC: UINavigationController
    
    enum Presentation {
        case post
        case info
    }
    
    init() {
        children = []
                
        feedNC = UINavigationController(rootViewController: feedVC)
        feedNC.tabBarItem = UITabBarItem(title: "Feed",
                                         image: UIImage(systemName: "text.bubble"),
                                         selectedImage: UIImage(systemName: "text.bubble.fill"))
        controller = feedNC
    }
    
    func setup() {
        feedVC.coordinator = self
    }
    
    func present(_ presentation: Presentation) {
        switch presentation {
        case .post:
            let post = postExamples[0]
            
            let postVC = PostViewController()
            postVC.coordinator = self
            postVC.post = post
            feedNC.pushViewController(postVC, animated: true)
        case .info:
            let infoVC = InfoViewController()
            feedNC.present(infoVC, animated: true, completion: nil)
        }
    }
}
