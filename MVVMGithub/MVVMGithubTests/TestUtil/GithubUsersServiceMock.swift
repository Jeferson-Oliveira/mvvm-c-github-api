import Foundation

@testable import MVVMGithub

class GithubUsersServiceMock: GithubServiceProtocol {
    var shouldReturnSucess = true
    var getUsersCalled = false
    var getUserDetailCalled = false
    var getUserReposCalled = false
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        getUsersCalled = true
        if shouldReturnSucess {
            completion(.success(User.mock()))
        } else {
            completion(.failure(NSError(domain: "github", code: 500)))
        }
    }
    
    func getUser(name: String, completion: @escaping (Result<User, Error>) -> Void) {
        getUserDetailCalled = true
        if shouldReturnSucess {
            completion(.success(.mock()))
        } else {
            completion(.failure(NSError(domain: "github", code: 500)))
        }
    }
    
    func getUserRepositories(name: String, completion: @escaping (Result<[UserRepository], Error>) -> Void) {
        getUserReposCalled = true
        if shouldReturnSucess {
            completion(.success(UserRepository.mock()))
        } else {
            completion(.failure(NSError(domain: "github", code: 500)))
        }
    }
}
