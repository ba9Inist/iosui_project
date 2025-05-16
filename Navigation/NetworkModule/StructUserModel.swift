//
//  StructUserModel.swift
//  Navigation
//
//  Created by Егор Голубев on 28.04.2025.
//

/*
 "userId": 1,
 "id": 1,
 "title": "delectus aut autem",
 "completed": false
 */

import Foundation
import UIKit

struct StructUserModel {
    
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
}

struct StructUserModelNew: Codable {
    
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
}
