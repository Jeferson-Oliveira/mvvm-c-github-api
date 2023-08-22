import Foundation

// MARK: - User
struct User: Codable {
    let id: Int?
    let login: String?
    let avatarUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
        let urlString = try container.decodeIfPresent(String.self, forKey: .avatarUrl) ?? .empty
        self.avatarUrl = URL(string: urlString)
    }
}
