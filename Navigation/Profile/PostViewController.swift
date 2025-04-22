//
//  PostViewController.swift
//  Navigation
//

import UIKit

final class PostViewController: UIViewController {
    
    var post: Post?
    var coordinator: FeedCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post?.author ?? "-"
        view.backgroundColor = .systemYellow
        
        // add a button in the navigtion bar
        let barButton = UIBarButtonItem(title: "Info", style: .done, target: self, action: #selector(tapInfoButton))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func tapInfoButton() {
//        let infoVC = InfoViewController()
//        present(infoVC, animated: true, completion: nil)
        coordinator?.present(FeedCoordinator.Presentation.info)
    }
}
