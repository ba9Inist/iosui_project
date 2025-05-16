//
//  LoginInspector.swift
//  Navigation
//
//  Created by Егор Голубев on 21.04.2025.
//

import UIKit

protocol LoginViewControllerDelegate {
    func checkCredentials(email: String, password: String, completion: @escaping (Bool) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void)
}

class LoginInspector: LoginViewControllerDelegate {
    func checkCredentials(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Checker().checkCredentials(email: email, password: password) { result in
            completion(result)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Checker().signUp(email: email, password: password) { result in
            completion(result)
        }
    }
    
    

}
