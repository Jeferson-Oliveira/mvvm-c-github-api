import Foundation

struct UserRepository: Codable {
    let name: String?
    let repoDescription: String?
    let url: URL?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url = "html_url"
        case repoDescription = "description"
    }
}
