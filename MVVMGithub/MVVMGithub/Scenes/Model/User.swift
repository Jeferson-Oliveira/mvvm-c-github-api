import Foundation

struct User: Codable {
    let id: Int?
    let login: String?
    let name: String?
    let email: String?
    let company: String?
    let avatarUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case email
        case company
        case avatarUrl = "avatar_url"
    }
    
    init(id: Int?, login: String?, name: String?, email: String?, company: String?, avatarUrl: URL?) {
        self.id = id
        self.login = login
        self.name = name
        self.email = email
        self.company = company
        self.avatarUrl = avatarUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.login = try container.decodeIfPresent(String.self, forKey: .login)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.company = try container.decodeIfPresent(String.self, forKey: .company)
        self.avatarUrl = try container.decodeIfPresent(URL.self, forKey: .avatarUrl)
    }
}
