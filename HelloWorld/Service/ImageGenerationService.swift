//
//  ImageGenerationController.swift
//  HelloWorld
//
//  Created by Bhavana Kumar on 12.02.23.
//

import Foundation

protocol ImageGenerationServiceProtocol {
    func generateImage(prompt: String) async throws -> ImageGenerationResponse
}

class ImageGenerationService: ImageGenerationServiceProtocol {
    func generateImage(prompt: String) async throws -> ImageGenerationResponse {
        let localData: Data = try await self.readLocalJSONFile(fileName: "APISecret")
        let apiJSONData: APIMapper = try await self.parse(jsonData: localData)
        
        guard let url = URL(string: apiJSONData.url ) else {
            throw ImageGenerationError.badURL("Not a valid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let requestBody = try JSONEncoder().encode(ImageGenerationRequest(prompt: prompt))
        
        request.httpBody = requestBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiJSONData.key, forHTTPHeaderField: "Authorization")
        
        do {
            let (apiResponse,_) =  try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(ImageGenerationResponse.self, from: apiResponse)
        }
        catch {
            throw ImageGenerationError.apiCallFail("Call to the DALEE API failed")
        }
        
    }
    private func readLocalJSONFile(fileName: String) async throws -> Data {
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName,
                                                 ofType: "json"),
               let rawFileData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            {
                return rawFileData
            }
        } catch {
            throw ImageGenerationError.errorReadingAPIKeyFile("Error Reading API config file")
        }
        throw ImageGenerationError.fileNotFound("There is something wrong in the file name or the file containing the API config")
    }
    private func parse(jsonData: Data) async throws -> APIMapper {
        do {
            return try JSONDecoder().decode(APIMapper.self,
                                            from: jsonData)
        } catch {
            throw ImageGenerationError.errorParsingAPIKey("Parsing API config failed")
        }
    }
}

