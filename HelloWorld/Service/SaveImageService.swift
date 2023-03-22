//
//  SaveImageService.swift
//  HelloWorld
//
//  Created by Bhavana Kumar on 13.03.23.
//

import Foundation
import UIKit

class SaveImageService: NSObject {
    func saveImage(image: UIImage) throws -> Bool {
         UIImageWriteToSavedPhotosAlbum (image,
                                        self,
                                        #selector(image(_:didFinishSavingWithError: contextInfo:)),
                                        nil)
        return true;
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) throws {
        if let error = error {
            throw SaveImageError.saveError("Could not save Image to device" + error.localizedDescription)
        }
    }
}

