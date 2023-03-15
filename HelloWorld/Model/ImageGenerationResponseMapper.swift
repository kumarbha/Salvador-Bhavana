import Foundation

struct ImageGenerationResponse: Decodable{
    let created: Int
    let data: [ImageURL]
}

struct ImageURL: Decodable {
    let url: URL
}
