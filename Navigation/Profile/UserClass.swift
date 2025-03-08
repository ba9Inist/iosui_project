//
//  UserClass.swift
//  Navigation
//
//  Created by Егор Голубев on 07.03.2025.
//

import Foundation
import UIKit

class User {
    
    var loginUser: String = "loginEntrance"
    var fullName: String = "Golubev Egor"
    var statusProfile: String = "Hello world"
    var imgProfile: UIImage = UIImage(resource: .teo)
    
//    init(loginUser: String, fullname: String, statusProfile: String, imgProfile: UIImage) {
//        self.loginUser = loginUser
//        self.fullName  = fullname
//        self.statusProfile = statusProfile
//        self.imgProfile = imgProfile
//    }
    
}

protocol UserService {
    func getUser(byLogin login: String) -> User?
}

class CurrentUserService: UserService {
    private let userEntrance: User
    
    init(userEntrance: User) {
        self.userEntrance = userEntrance
    }
    
    func getUser(byLogin login: String) -> User? {
        if login == userEntrance.loginUser {
            return userEntrance
        }
        return nil
    }
}


class TestUserService: UserService {

    var userTest: User = User()
    init(userTest: User) {
        self.userTest = userTest
        userTest.loginUser = "TestLogin"
        userTest.fullName  = "Test Egor"
        userTest.statusProfile = "Hello test"
        userTest.imgProfile = UIImage(resource: .post1)
    }

    func getUser(byLogin login: String) -> User? {
        if login == userTest.loginUser {
            return userTest
        }
        return nil
    }
    
    
}
