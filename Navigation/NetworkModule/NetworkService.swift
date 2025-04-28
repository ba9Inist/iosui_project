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
    case foURL = "https://jsonplaceholder.typicode.com/todos/1"
    case fiveURL = "https://jsonplaceholder.typicode.com/todos/2"
}

struct NetworkService {
    
    static func request(for configuration: AppConfiguration, completion: @escaping (StructUserModelNew?) -> Void) {
        
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
                completion(nil)
                return
            }
            
            if codeServer != 200 {
                print("Code server \(codeServer)")
                completion(nil)
                return
            }
            
            guard let data else {
                print("not data")
                completion(nil)
                return
            }
            
            do {
                
                if configuration == AppConfiguration.oneURL {
                    let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    let textJson = answer?["name"] as? String ?? ""
                    print(textJson)
                } else if configuration == AppConfiguration.foURL {
                    let answer = try JSONSerialization.jsonObject(with: data,options: [])
                    if let dictAnswer = answer as? [String: Any] {
                        
                        var completedBool: Bool = false
                        var idJs: Int = 0
                        var titleJs: String = ""
                        var userIdJs: Int = 0
                        
                        if let completed = dictAnswer["completed"] as? Int {
                            completedBool = completed == 0 ? false : true
                        }
                        
                        if let id = dictAnswer["id"] as? Int {
                            idJs = id
                        }
                        
                        if let title = dictAnswer["title"] as? String {
                            titleJs = title
                        }
                        
                        if let userId = dictAnswer["userId"] as? Int {
                            userIdJs = userId
                        }
                        
                        let userModel = StructUserModel.init(userId: userIdJs, id: idJs, title: titleJs, completed: completedBool)
                        //completion(userModel)
                    }
                    
                } else if configuration == AppConfiguration.fiveURL {
                    
                    let answer = try JSONDecoder().decode(StructUserModelNew.self,from: data)
                    print(answer)
                    completion(answer)

                    
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        httpRequest.resume()
        
    }
    
}
