import Foundation

@testable import MVVMGithub

extension User {
    static func mock() -> User {
        return User(id: -1,
                    login: "jefersonoliver7",
                    name: "Jeferson Oliveira",
                    email: "jeferson@maill.com",
                    company: "Mock Company",
                    avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/1?v=4"))
    }
    
    static func mock() -> [User] {
        var users = [User]()
        for i in 0...20 {
            users.append(User(id: i,
                              login: "mockUser\(i)",
                              name: "Jeferson Oliveira",
                              email: "jeferson@maill.com",
                              company: "Mock Company",
                              avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/1?v=4")))
        }
        return users
    }
}


extension UserRepository {
    static func mock() -> [UserRepository] {
        var repos = [UserRepository]()
        for i in 0...20 {
            repos.append(.init(name: "Fantastic Project \(i)",
                               repoDescription: "This is a fantastic project description",
                               url: URL(string: "https://github.com/torvalds/libdc-for-dirk")))
        }
        return repos
    }
    
    static func mock() -> UserRepository {
        return UserRepository(name: "Fantastic Project",
                              repoDescription: "This is a fantastic project description",
                              url: URL(string: "https://github.com/torvalds/libdc-for-dirk"))
    }
}
