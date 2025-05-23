//
//  accessPhoto.swift
//  Navigation
//
//  Created by Егор Голубев on 22.05.2025.
//

import Foundation
import Photos

import Photos


class AccessPhoto {
 
    func requestGalleryAccess(completion: @escaping (_ granted: Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                completion(true)
            case .denied, .restricted:
                completion(false)
            case .notDetermined:
                break 
            case .limited:
                completion(true)
            @unknown default:
                completion(false)
            }
        }
    }

    
}
