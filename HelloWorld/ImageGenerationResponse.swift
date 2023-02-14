import Foundation

struct ImageGenerationResponse: Codable{
    struct ImageURL: Codable {
        let url: URL
    }
    let created: Int
    let data: [ImageURL]
}
