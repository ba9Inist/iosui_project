//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Егор Голубев on 14.04.2025.
//

import Foundation
import UIKit

final class ProfileViewModel {

    private(set) var user: User
    private(set) var posts: [Post] = []

    var onDataUpdated: (() -> Void)?

    init(user: User) {
        self.user = user
    }

    func fetchUserData() {
        onDataUpdated?()
    }

    func fetchPosts() {
        self.posts = postExamples 
        onDataUpdated?()
    }
}
