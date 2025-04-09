//
//  FeedModel.swift
//  Navigation
//
//  Created by Егор Голубев on 09.04.2025.
//

import Foundation
import UIKit

class FeedModel {
    
    var secretWord: String = "admin"
        
    func check (word: String) -> Bool {
        
        var success: Bool = false
        
        if word == secretWord {
            success = true
        }
        
        return success
        
    }
}
