//
//  CheckerMock.swift
//  NavigationTests
//
//  Created by Егор Голубев on 22.07.2025.
//

import Foundation
@testable import Navigation

class CheckerMock: LoginViewControllerDelegate {
    var mockCheckCredentialsSuccess: Bool = true
    var mockSignUpSuccess: Bool = true
    
    func checkCredentials(email: String, password: String, completion: @escaping (Bool) -> Void) {
        completion(mockCheckCredentialsSuccess)
    }
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        completion(mockSignUpSuccess)
    }
}
