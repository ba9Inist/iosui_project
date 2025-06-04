//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Егор Голубев on 03.06.2025.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LikePostModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error $error), $error.userInfo)")
            }
        })
        return container
    }()
    
    func savePost(post: Post) {
        
        
        let double = checkDouble(key: "uuidPost", value: post.id)
        
        if !double {
            
            let context = persistentContainer.viewContext
            
            let likedPost = LikePost(context: context)
            likedPost.uuidPost = post.id
            likedPost.author = post.author
            likedPost.content = post.description
            likedPost.image = post.image
            likedPost.views = Int16(post.views)
            likedPost.likes = Int16(post.likes)
            do {
                try context.save()
            } catch {
                print("Failed saving: $error.localizedDescription)")
            }
        }
    }
    
    private func checkDouble(key: String, value: String) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LikePost")
        fetchRequest.predicate = NSPredicate(format: "%K == %@", argumentArray: [key, value])
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0 ? true : false
        } catch {
            return false
        }
    }
    
    func loadLikedPosts() -> [Post] {
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<LikePost> = LikePost.fetchRequest()
        do {
             let arrayCoreDataPost = try context.fetch(request)
            let arrayLikePost = convertToPosts(coreDataPosts: arrayCoreDataPost)
            return arrayLikePost
        } catch {
            print("Fetching failed: $error.localizedDescription)")
            return [Post]()
        }
        
    }
    
    private func convertToPosts(coreDataPosts: [LikePost]) -> [Post] {
        return coreDataPosts.map { likePost in
            Post(
                author: likePost.author ?? "",
                description: likePost.content ?? "",
                image: likePost.image ?? "",
                likes: Int(likePost.likes),
                views: Int(likePost.views),
                id: likePost.uuidPost ?? ""
            )
        }
    }
    
    func resetCoreData() {
        let storeURL = persistentContainer.persistentStoreCoordinator.persistentStores.first?.url
        
        do {
            try persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: storeURL!, ofType: NSSQLiteStoreType, options: nil)
            try persistentContainer.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL!, options: nil)
        } catch {
            print("Error resetting Core Data: $error)")
        }
    }
}
