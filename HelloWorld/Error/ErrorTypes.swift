//
//  ErrorTypes.swift
//  HelloWorld
//
//  Created by Bhavana Kumar on 15.03.23.
//

import Foundation

enum SaveImageError: Error {
    case saveError(String)
}

enum ImageGenerationError: Error {
    case errorReadingAPIKeyFile(String)
    case errorParsingAPIKey(String)
    case apiCallFail(String)
    case fileNotFound(String)
}
