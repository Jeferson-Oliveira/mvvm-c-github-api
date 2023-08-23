import Foundation

enum UserDetailViewState {
    case loading
    case error(String)
    case userDetailLoaded
    case repositoriesLoaded
}

protocol UserDetailViewModelProtocol {
    func requestDetailInfo()
    func getUserDetails() -> User?
    func getUserRepositories() -> [UserRepository]
    func goToRepoUrl(index: Int)
}

class UserDetailViewModel: UserDetailViewModelProtocol {
    
    private let coordinator: GithubUsersCoordinatorProtocol
    private let githubService: GithubServiceProtocol
    private let userToDetail: User
    
    private var userDetailResponse: User?
    private var userRepositoriesResponse: [UserRepository]?

    weak var displayDelegate: UserDetailDisplayDelegate?

    init(userToDetail: User,
         githubService: GithubServiceProtocol = GithubUsersService(),
         coordinator: GithubUsersCoordinatorProtocol) {
        self.userToDetail = userToDetail
        self.githubService = githubService
        self.coordinator = coordinator
    }
    
    func getUserDetails() -> User? {
        return userDetailResponse
    }
    
    func getUserRepositories() -> [UserRepository] {
        return userRepositoriesResponse ?? []
    }
    
    func goToRepoUrl(index: Int) {
        guard let url = getUserRepositories()[index].url else { return }
        coordinator.router(to: .repoUrl(url))
    }
    
    func requestDetailInfo() {
        self.displayDelegate?.didUpdateViewState(state: .loading)
        githubService.getUser(name: userToDetail.login ?? .empty) { result in
            switch result {
            case .success(let user):
                self.userDetailResponse = user
                self.displayDelegate?.didUpdateViewState(state: .userDetailLoaded)
            case .failure(let error):
                self.displayDelegate?.didUpdateViewState(state: .error(error.localizedDescription))
            }
        }
        
        githubService.getUserRepositories(name: userToDetail.login ?? .empty) { result in
            switch result {
            case .success(let repositories):
                self.userRepositoriesResponse = repositories
                self.displayDelegate?.didUpdateViewState(state: .repositoriesLoaded)
            case .failure(let error):
                self.displayDelegate?.didUpdateViewState(state: .error(error.localizedDescription))
            }
        }
    }
}
