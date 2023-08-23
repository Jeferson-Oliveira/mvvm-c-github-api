import Foundation

struct GithubAPIParams {
    fileprivate static let baseURL = "https://api.github.com"
}

enum Endpoints {
    case listUsers
    case userDetail(String)
    
    func url() -> String {
        switch self {
        case .listUsers:
            return GithubAPIParams.baseURL + "/users"
        case .userDetail(let name):
            return GithubAPIParams.baseURL + "/users/\(name)"
        }
    }
}
