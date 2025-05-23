//
//  CheckerClass.swift
//  Navigation
//
//  Created by Егор Голубев on 31.03.2025.
//

import Foundation
import UIKit
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String,  completion: @escaping ((Bool) -> Void))
    func signUp(email: String, password: String, completion: @escaping ((Bool) -> Void))
}


class Checker: CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error != nil, let error = error as NSError? {
                            if let errorCode = AuthErrorCode(rawValue: error.code) {
                                switch errorCode {
                                case .invalidCredential:
                                    self.setubAlert(title: "Предупреждение", sms: "Пользователь не найден", type: .alert)
                                case .emailAlreadyInUse:
                                    self.setubAlert(title: "Предупрежение", sms: "Email некоректный", type: .alert)
                                case .wrongPassword:
                                    self.setubAlert(title: "Предупрежение", sms: "Пароль неверный", type: .alert)
                                default:
                                    break
                                }
                                completion(false)
                            }
                        } else {
                            completion(true)
                        }
            
        }
    }
    
    
    func signUp(email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.setubAlert(title: "Предупреждение", sms: error.localizedDescription, type: .alert)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    private func setubAlert (title: String, sms: String, type: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: sms, preferredStyle: type)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
            
}


protocol LoginFactory {
    func makeLoginInspector () -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
