//
//  SaveImageService.swift
//  HelloWorld
//
//  Created by Bhavana Kumar on 13.03.23.
//

import Foundation
import UIKit

class SaveImageService: NSObject {
    var saved: () -> Void = {}
    func saveImage(image: UIImage, savedCallback: @escaping () -> Void) throws {
         UIImageWriteToSavedPhotosAlbum (image,
                                        self,
                                        #selector(image(_:didFinishSavingWithError: contextInfo:)),
                                        nil)
        saved = savedCallback
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) throws {
        if let error = error {
            throw SaveImageError.saveError("Could not save Image to device" + error.localizedDescription)
        }
        else {
            saved();
        }
    }
}

