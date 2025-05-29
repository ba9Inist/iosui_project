//
//  LoginKeyChainVC.swift
//  Navigation
//
//  Created by Егор Голубев on 28.05.2025.
//

import UIKit
import SnapKit
import KeychainAccess

class LoginKeyChainVC: UIViewController {
    
    private lazy var keychain = Keychain(service: "only.one.Navigation")
    
    private lazy var pass: UITextField = {
        let pass = UITextField()
        pass.leftViewMode = .always
        pass.placeholder = "Password"
        pass.layer.borderColor = UIColor.lightGray.cgColor
        pass.layer.borderWidth = 1
        pass.layer.cornerRadius = 10
        pass.isSecureTextEntry = true
        pass.textColor = .black
        pass.font = UIFont.systemFont(ofSize: 30)
        pass.autocapitalizationType = .none
        pass.returnKeyType = .done
        pass.delegate = self
        return pass
    }()
    
    private lazy var passV2: UITextField = {
        let pass = UITextField()
        pass.leftViewMode = .always
        pass.placeholder = "Password"
        pass.layer.borderColor = UIColor.lightGray.cgColor
        pass.layer.borderWidth = 1
        pass.layer.cornerRadius = 10
        pass.isSecureTextEntry = true
        pass.textColor = .black
        pass.font = UIFont.systemFont(ofSize: 30)
        pass.autocapitalizationType = .none
        pass.returnKeyType = .done
        pass.isHidden = true
        pass.delegate = self
        return pass
    }()
    
    private lazy var regButton: UIButton = {
        let button = CustomButton(title: "",
                                  titleColor: .white,
                                  backgroundColor: .blue,
                                  cornerRadius: LayoutConstants.cornerRadius)
        button.addTarget(nil, action: #selector(touchRegButton), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setubSubviews()
        if keychain["passUser"] != nil {
            regButton.setTitle("Введите пароль", for: .normal)
        } else {
            regButton.setTitle("Создать пароль", for: .normal)
        }
        
    }
    
    private func setubSubviews() {
        
        view.addSubviews(pass, passV2, regButton)
        
        pass.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
            $0.left.equalTo(view.snp.left).inset(30)
            $0.right.equalTo(view.snp.right).inset(30)
        }
        
        regButton.snp.makeConstraints {
            $0.top.equalTo(pass.snp.bottom).inset(-30)
            $0.left.equalTo(view.snp.left).inset(30)
            $0.right.equalTo(view.snp.right).inset(30)
        }
        
        passV2.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
            $0.left.equalTo(view.snp.left).inset(30)
            $0.right.equalTo(view.snp.right).inset(30)
        }
        
        
    }
    
    @objc private func touchRegButton() {
        
        guard let passText = pass.text else { return }
        
        //pass 12345
        
        if keychain["passUser"] != nil {
            if passText != keychain["passUser"] {
                let customAlert = customAlert()
                customAlert.setubAlert(title: "Вход", sms: "Пароль не верный", type: .alert)
            } else {
                let vc = TabBarVC()
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true,completion: nil)
            }
        } else {
            if passText.isEmpty || passText.count < 4 {
                let customAlert = customAlert()
                customAlert.setubAlert(title: "Регистрация", sms: "Введен слабый пароль", type: .alert)
            } else {
                do {
                    if regButton.currentTitle == "Создать пароль" {
                        pass.isHidden = true
                        passV2.isHidden = false
                        regButton.setTitle("Повторно введите пароль", for: .normal)
                    } else {
                        guard let passTextV2 = passV2.text else { return }
                        
                        if passText == passTextV2 {
                            try keychain.set(passText, key: "passUser")
                            let vc = TabBarVC()
                            vc.modalPresentationStyle = .fullScreen
                            present(vc, animated: true, completion: nil)
                        } else {
                            let customAlert = customAlert()
                            customAlert.setubAlert(title: "Регистрация", sms: "Пароли не совпадают", type: .alert)
                        }
                    }
                } catch {
                    print("Ошибка сохранения пароля:", error.localizedDescription)
                }
            }
        }
    }
}

extension LoginKeyChainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        touchRegButton()
        return true
    }
}
