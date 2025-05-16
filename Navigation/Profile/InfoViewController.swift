//
//  InfoViewController.swift
//  Navigation
//

import UIKit

final class InfoViewController: UIViewController {
    
    private lazy var buttonAlert: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Alert", for: .normal)
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.addTarget(self, action: #selector(tapAlertButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test"
        return label
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        view.addSubview(buttonAlert)
        view.addSubview(label)
        setupConstraints()
        
        DispatchQueue.main.async {
            NetworkService.request(for: AppConfiguration.fiveURL) { [weak self] userModel in
                if let userModel = userModel {
                    DispatchQueue.main.async {
                        self?.label.text = userModel.title
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.label.text = "Text undefined"
                    }
                }
            }
        }
        

    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            buttonAlert.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonAlert.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            buttonAlert.heightAnchor.constraint(equalToConstant: 50),
            buttonAlert.widthAnchor.constraint(equalToConstant: 100),
            
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50),
            label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 110),
            label.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 30),
            label.heightAnchor.constraint(equalToConstant: 30),
            label.widthAnchor.constraint(equalToConstant: 100)
            
        ])
        
    }

    @objc func tapAlertButton() {
        let alert = UIAlertController(title: "Attention",
                                      message: "How are you feeling?",
                                      preferredStyle: .alert)
        // add two buttons
        let fine = UIAlertAction(title: "Fine", style: .default) { _ in
            print("Fine")
        }
        alert.addAction(fine)
        
        let so = UIAlertAction(title: "So-so", style: .destructive) { _ in
            print("So-so")
        }
        alert.addAction(so)

        self.present(alert, animated: true, completion: nil)
    }
}
