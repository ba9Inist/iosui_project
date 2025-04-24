//
//  NetworkService.swift
//  Navigation
//
//  Created by Егор Голубев on 24.04.2025.
//

import Foundation
import UIKit

enum AppConfiguration: String{
    case oneURL = "https://swapi.dev/api/people/8"
    case twoURL = "https://swapi.dev/api/starships/3"
    case fhreeURL = "https://swapi.dev/api/planets/5"
}

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        
        let sessia = URLSession.shared
        let url = URL(string: configuration.rawValue)
        let httpRequest = sessia.dataTask(with: url!) {data ,responce, error in
            
            var codeServer = 200
            let httpUrlRequest = responce as? HTTPURLResponse
            codeServer = httpUrlRequest?.statusCode ?? 404
            
            print(codeServer)
            
            if error != nil {
                print("Произошла ошибка:\((error?.localizedDescription ?? "error"))")
                //Произошла ошибка:An SSL error has occurred and a secure connection to the server cannot be made.
                return
            }
                        
            if codeServer != 200 {
                print("Code server \(codeServer)")
                return
            }
            
            guard let data else {
                print("not data")
                return
            }
            
            do {
                
                let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                let textJson = answer?["name"] as? String ?? ""
                print(textJson)
            } catch {
                
            }
            
            
            
        }
        
        httpRequest.resume()

        
        
    }
    
}
