//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by Егор Голубев on 07.07.2025.
//

import XCTest
@testable import Navigation

final class NavigationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    

    // Проверяет случай, когда введен правильный пароль ("admin").
    func testCheck_ReturnsTrue_ForAdmin() {
        let feedModel = FeedModel()
        let result = feedModel.check(word: "admin")
        XCTAssertTrue(result, "Метод check() должен вернуть true для admin.")
    }

    // Проверяет случай, когда введен неправильный пароль ("guest").
    func testCheck_ReturnsFalse_ForGuest() {
        let feedModel = FeedModel()
        let result = feedModel.check(word: "guest")
        XCTAssertFalse(result, "Метод check() должен вернуть false для guest.")
    }

    // Проверяет обработку пустой строки.
    func testCheck_ReturnsFalse_ForEmptyString() {
        let feedModel = FeedModel()
        let result = feedModel.check(word: "")
        XCTAssertFalse(result, "Метод check() должен вернуть false для пустой строки.")
    }

}
