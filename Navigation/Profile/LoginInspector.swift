//
//  LoginInspector.swift
//  Navigation
//
//  Created by Егор Голубев on 21.04.2025.
//

import UIKit

class LoginInspector: LoginViewControllerDelegate {

    func check(loginCheck: String, passCheck: String) -> Bool {
        return Checker.check(loginCheck: loginCheck, passCheck: passCheck)
    }
}
