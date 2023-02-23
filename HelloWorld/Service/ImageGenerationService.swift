//
//  ImageGenerationController.swift
//  HelloWorld
//
//  Created by Bhavana Kumar on 12.02.23.
//

import Foundation

struct ImageGenerationService {
    func generateImage(prompt: String) async throws -> ImageGenerationResponse {
        let localData: Data = try await self.readLocalJSONFile(fileName: "APISecret")!
        let apiSecretKey = try await self.parse(jsonData: localData)
        
        let url = URL(string: "https://api.openai.com/v1/images/generations")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let requestBody = try JSONEncoder().encode(ImageGenerationRequest(prompt: prompt))
        
        request.httpBody = requestBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiSecretKey, forHTTPHeaderField: "Authorization")
        
        do {
            let (apiResponse,_) =  try await URLSession.shared.data(for: request)
            let jsonResult = try JSONDecoder().decode(ImageGenerationResponse.self, from: apiResponse)
            return jsonResult
        }
        catch {
            throw ImageGenerationError.apiCallFail("Call to the DALEE API failed")
        }
        
    }
    private func readLocalJSONFile(fileName: String) async throws -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName,
                                                 ofType: "json"),
               let rawFileData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            {
                return rawFileData
            }
        } catch {
            throw ImageGenerationError.errorReadingAPIKeyFile("Error Reading API keys file")
        }
        throw ImageGenerationError.fileNotFound("File name or the file containing API keys not found")
    }
    private func parse(jsonData: Data) async throws -> String {
        do {
            let data = try JSONDecoder().decode(APIKeyMapper.self,
                                                from: jsonData)
            return data.key
        } catch {
            throw ImageGenerationError.errorParsingAPIKey("Parsing API key failed")
        }
    }
    enum ImageGenerationError: Error {
        case errorReadingAPIKeyFile(String)
        case errorParsingAPIKey(String)
        case apiCallFail(String)
        case fileNotFound(String)
    }
    
}
