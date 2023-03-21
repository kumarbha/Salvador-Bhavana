//
//  MockImageGenerationService.swift
//  HelloWorld_Tests
//
//  Created by Bhavana Kumar on 16.03.23.
//

import Foundation
@testable import HelloWorld

class MockImageGenerationService: ImageGenerationServiceProtocol {
    func generateImage(prompt: String) async throws -> ImageGenerationResponse {
        let url = URL(string: "https://example.com")
        let imageURL = ImageURL(url: url!)
        switch prompt {
        case "badURL":
            throw ImageGenerationError.badURL("BAD URL")
       /* case "errorReadingAPIKeyFile":
            throw ImageGenerationError.errorReadingAPIKeyFile("ERROR READING APIKEY FROM FILE")
        case "errorParsingAPIKey":
            throw ImageGenerationError.errorParsingAPIKey("ERROR PARSING API KEY TO JSON")
        case "fileNotFound":
            throw ImageGenerationError.fileNotFound("THE FILE THAT STORES API KEY IS MISSING")
        case "apiCallFail":
            throw ImageGenerationError.apiCallFail("CALL TO OPEN AI FAILED") */
        default:
            let imageResponse = ImageGenerationResponse(created: 123, data: [imageURL])
            return imageResponse
        }
    }
}
