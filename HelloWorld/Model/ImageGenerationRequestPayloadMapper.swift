//
//  ImageGenerationRequestPayloadMapper.swift
//  HelloWorld
//
//  Created by Bhavana Kumar on 22.02.23.
//

import Foundation

struct ImageGenerationRequest: Encodable{
    let prompt: String
    let size: String = "1024x1024"
    var n: Int = 1
}
