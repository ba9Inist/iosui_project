//
//  CheckerClass.swift
//  Navigation
//
//  Created by Егор Голубев on 31.03.2025.
//

import Foundation
import UIKit

class Checker {
    
    private static var object: Checker?
    private static let login: String  = "admin"
    private static let pass: String = "123"


     private init() {
     }

     static func getObject() -> Checker {
         if object == nil {
             object = Checker()
         }
         return object!
     }
    
    static func check (loginCheck: String, passCheck: String) -> Bool {
        var success = true
        if loginCheck != login || passCheck != pass {
            success = false
        }
        return success
     }
    
}


protocol LoginViewControllerDelegate {
    func check (loginCheck: String, passCheck: String) -> Bool 
}
