import Foundation

@testable import MVVMGithub

extension User {
    static func mock() -> User {
        return User(id: -1, login: "jefersonoliver7", avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/1?v=4"))
    }
    
    static func mock() -> [User] {
        var users = [User]()
        for i in 0...20 {
            users.append(User(id: i, login: "mockUser\(i)", avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/1?v=4")))
        }
        return users
    }
}
