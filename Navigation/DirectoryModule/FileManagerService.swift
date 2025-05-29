//
//  FileManagerService.swift
//  Navigation
//
//  Created by Егор Голубев on 22.05.2025.
//

import Foundation
import UIKit


final class FileManagerService {
    
    let path: String
    var photoArray = [String]()
    struct infoPhoto {
        let name: String
        let pathPhoto: String
    }
    
    init(path: String) {
        self.path = path
    }
    
    func loadArray() {
        do {
            let files = try FileManager.default.contentsOfDirectory(
                atPath: path
            )
            photoArray = files.filter({ $0.hasSuffix(".jpg") })
            let sort = UserDefaults.standard.integer(forKey: "selectedIndex")
            switch sort {
            case 0:
                photoArray.sort()
            case 1:
                photoArray.sort(by: >)
            default:
                break
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removePhoto(index: Int) {
        
        if photoArray.indices.contains(index) {
            let element = photoArray[index]
            let fullNamePhoto = path + "/" + element
            if FileManager.default.fileExists(atPath: fullNamePhoto) {
                do {
                    try FileManager.default.removeItem(atPath: fullNamePhoto)
                    photoArray.remove(at: index)
                } catch {
                    print("Ошибка удаления файла: \(error.localizedDescription)")
                }
            } else {
                print("Файл не найден")
            }
        }
    }
 
    func showPhotoCell(index: Int) -> infoPhoto {
        if photoArray.indices.contains(index) {
            let element = photoArray[index]
            let fullNamePhoto = path + "/" + element
            if FileManager.default.fileExists(atPath: fullNamePhoto) {
                return infoPhoto(name: element, pathPhoto: fullNamePhoto)
            }
        }
        return infoPhoto(name: "Файл не найден", pathPhoto: "")
    }
    
}
