//
//  LoginFactory.swift
//  Navigation
//
//  Created by Егор Голубев on 21.04.2025.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
