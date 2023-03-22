//
//  ImageGenerationViewModel.swift
//  HelloWorld
//
//  Created by Bhavana Kumar on 21.02.23.
//

import Foundation
import UIKit


@MainActor class ImageGenerationViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isWorking: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    var imageGenerationServiceInstance: ImageGenerationServiceProtocol
    
    init(imageGenerationServiceInstance: ImageGenerationServiceProtocol) {
        self.imageGenerationServiceInstance = imageGenerationServiceInstance;
    }
    
    func sendRequest(prompText: String) async {
        isWorking = true
        do {
            let response = try await imageGenerationServiceInstance.generateImage(prompt: prompText)
            let imageURL = response.data[0].url
            let (data,_) = try await URLSession.shared.data(from: imageURL)
            image = UIImage(data: data)
            isWorking = false
        }
        catch ImageGenerationError.badURL(let msg){
            setFlags(msg)
        }
        catch ImageGenerationError.apiCallFail(let msg){
            setFlags(msg)
        }
        catch ImageGenerationError.errorParsingAPIKey(let msg){
            setFlags(msg)
        }
        catch ImageGenerationError.errorReadingAPIKeyFile(let msg){
            setFlags(msg)
        }
        catch ImageGenerationError.fileNotFound(let msg){
            setFlags(msg)
        }
        catch SaveImageError.saveError(let msg){
            setFlags(msg)
        }
        catch {
            setFlags(error.localizedDescription)
        }
        
    }
    
    fileprivate func setFlags(_ msg: String) {
        isWorking = false
        showAlert = true
        alertMessage = msg
    }
    
    func saveImage(image: UIImage) {
        do {
            let isImageSaved = try SaveImageService().saveImage(image: image);
            if(isImageSaved) {
                showAlert = true
                alertMessage = "Saved successfully"
            }
        }
        catch {
            showAlert = true
            alertMessage = error.localizedDescription;
        }
    }
}

