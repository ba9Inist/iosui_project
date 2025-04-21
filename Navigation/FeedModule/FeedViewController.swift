//
//  FeedViewController.swift
//  Navigation
//

import UIKit

final class FeedViewController: UIViewController {
    
    lazy var passUiTextField: UITextField = {
        let pass = UITextField()
        pass.translatesAutoresizingMaskIntoConstraints = false
        pass.layer.cornerRadius = 5
        pass.backgroundColor = .white
        return pass
    }()
    
    lazy var checkGuessButton: UIButton = {
        let button = CustomButton(title: "Проверка пароля",
                                  titleColor: .white,
                                  backgroundColor: .orange,
                                  cornerRadius: 5)
        button.addTarget(self, action: #selector(tapCustomButton), for: .touchUpInside)
        return button
    }()
    
    var coordinator: FeedCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        createSubView()
    }
    
    private func createSubView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32)
        ])
        addPostButton(title: "Post number One", color: .systemPurple, to: stackView, selector: #selector(tapPostButton))
        addPostButton(title: "Post number Two", color: .systemIndigo, to: stackView, selector: #selector(tapPostButton))
        
        view.addSubview(passUiTextField)
        NSLayoutConstraint.activate([
            passUiTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            passUiTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15),
            passUiTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15),
            passUiTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(checkGuessButton)
        
        NSLayoutConstraint.activate([
            checkGuessButton.topAnchor.constraint(equalTo: passUiTextField.bottomAnchor, constant: 15),
            checkGuessButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15),
            checkGuessButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func addPostButton(title: String, color: UIColor, to view: UIStackView, selector: Selector) {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.addTarget(self, action: selector, for: .touchUpInside)
        view.addArrangedSubview(button)
    }
    
    @objc func tapPostButton() {
        
        let post = postExamples[0]
        coordinator?.showPost(with: post)
        
//        let postVC = PostViewController()
//        postVC.post = post
//        navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc func tapCustomButton() {
        let checkpass = FeedModel()
        let success = checkpass.check(word: passUiTextField.text ?? "")
        if success {
            checkGuessButton.backgroundColor  = .green
        } else {
            checkGuessButton.backgroundColor = .red
        }
    }
    
}
