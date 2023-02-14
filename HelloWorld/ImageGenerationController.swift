//
//  ImageGenerationController.swift
//  HelloWorld
//
//  Created by Bhavana Kumar on 12.02.23.
//

import Foundation

struct ImageGenerationController {
        
    func generateImage(prompt: String) async throws -> ImageGenerationResponse {
        let url = URL(string: "https://api.openai.com/v1/images/generations")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
         
        let requestPayload: [String:Any] = ["prompt": prompt, "size": "1024x1024", "n":1]
        let jsonData = try! JSONSerialization.data(withJSONObject: requestPayload)

        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Configuration.apiKey, forHTTPHeaderField: "Authorization")

        let (apiResponse,_) = try await URLSession.shared.data(for: request)
        let jsonResult = try JSONDecoder().decode(ImageGenerationResponse.self, from: apiResponse)
        return jsonResult
    }
}
