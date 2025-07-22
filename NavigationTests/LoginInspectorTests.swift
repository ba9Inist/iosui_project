//
//  LoginInspectorTests.swift
//  NavigationTests
//
//  Created by Егор Голубев on 22.07.2025.
//

import Foundation
import XCTest
@testable import Navigation

class LoginInspectorTests: XCTestCase {
    
    var inspector: LoginInspector!
    var checkerMock: CheckerMock!
    
    override func setUp() {
        super.setUp()
        checkerMock = CheckerMock()
        inspector = LoginInspector()
    }
    
    override func tearDown() {
        inspector = nil
        checkerMock = nil
        super.tearDown()
    }
    
    // Тест на успешную проверку учетных данных
    func testCheckCredentials_Successful() {
        let expectation = expectation(description: "Check Credentials Success")
        checkerMock.mockCheckCredentialsSuccess = true
        inspector.checkCredentials(email: "test@mail.ru", password: "qwerty123") { result in
            // Assert
            XCTAssertTrue(result, "Проверка должна была завершиться успехом!")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Тест на неудачную проверку учетных данных
    func testCheckCredentials_Unsuccessful() {
        let expectation = expectation(description: "Check Credentials Failure")
        checkerMock.mockCheckCredentialsSuccess = false
        inspector.checkCredentials(email: "test@example.com", password: "badPass") { result in
            XCTAssertFalse(result, "Проверка должна была завершиться неудачей!")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Тест на успешную регистрацию
    func testSignUp_Successful() {
        let expectation = expectation(description: "Sign Up Success")
        checkerMock.mockSignUpSuccess = true
        inspector.signUp(email: "newUser@example.com", password: "strongPass") { result in
            XCTAssertTrue(result, "Регистрация должна была завершиться успехом!")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Тест на неудачную регистрацию
    func testSignUp_Unsuccessful() {
        let expectation = expectation(description: "Sign Up Failure")
        checkerMock.mockSignUpSuccess = false
        inspector.signUp(email: "newUser@example.com", password: "weakPass") { result in
            XCTAssertFalse(result, "Регистрация должна была завершиться неудачей!")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
