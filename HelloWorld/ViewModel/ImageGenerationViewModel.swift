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
    @Published var errorMessage: String = ""
    
    func sendRequest(prompText: String) {
        Task {
            isWorking = true
            do {
                let response = try await ImageGenerationService().generateImage(prompt: prompText)
                let imageURL = response.data[0].url
                let (data,_) = try await URLSession.shared.data(from: imageURL)
                image = UIImage(data: data)
                isWorking = false
            }
            catch {
                isWorking = false
                showAlert = true
                errorMessage = error.localizedDescription
                
            }
        }
    }
}

