import Foundation
import Alamofire

protocol GithubServiceProtocol {
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void)
    func getUser(name: String, completion: @escaping (Result<User, Error>) -> Void)
}

class GithubUsersService: GithubServiceProtocol {
    
    private let sessionManager = Alamofire.Session.default
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        request(endpoint: Endpoints.listUsers.url(), completion: completion)
    }
    
    func getUser(name: String, completion: @escaping (Result<User, Error>) -> Void) {
        request(endpoint: Endpoints.userDetail(name).url(), completion: completion)
    }

    func request<T: Codable>(endpoint: String,
                             method: HTTPMethod = .get,
                             parameters: Parameters? = nil,
                             completion: @escaping (Result<T, Error>) -> Void) {
        self.sessionManager
            .request(endpoint,
                     method: method,
                     parameters: parameters,
                     encoding: JSONEncoding.default,
                     headers: ["Authorization" : GithubAPIParams.authParams])
            .responseDecodable(of: T.self, completionHandler: { response in
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
    }
}
