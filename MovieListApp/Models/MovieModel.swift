import Foundation

struct BaseResponse: Codable {
    
    let results: [Movie]
}

struct Movie: Codable {
    
    let id: Int
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
}
