import Foundation

enum UserListViewState {
    case loading
    case error(String)
    case usersLoaded
}

protocol GithubUsersListViewModelProtocol {
    func getUsers()
    func detailUser(index: Int)
    func getUsersCount() -> Int
    func getUserFronIndex(index: Int) -> User
}

class GithubUsersListViewModel: GithubUsersListViewModelProtocol {
    
    let coordinator: GithubUsersCoordinatorProtocol
    let githubService: GithubServiceProtocol
    var usersResponse = [User]()

    weak var displayDelegate: UserListDisplayDelegate?

    init(githubService: GithubServiceProtocol = GithubUsersService(),
         coordinator: GithubUsersCoordinatorProtocol) {
        self.githubService = githubService
        self.coordinator = coordinator
    }
    
    func getUsers() {
        self.displayDelegate?.didUpdateViewState(state: .loading)
        githubService.getUsers(completion: { result in
            switch result {
            case .success(let users):
                self.usersResponse = users
                self.displayDelegate?.didUpdateViewState(state: .usersLoaded)
            case .failure(let error):
                self.displayDelegate?.didUpdateViewState(state: .error(error.localizedDescription))
            }
        })
    }
    
    func detailUser(index: Int) {
        coordinator.router(to: .detail(getUserFronIndex(index: index)))
    }
    
    func getUsersCount() -> Int {
        return usersResponse.count
    }
    
    func getUserFronIndex(index: Int) -> User {
        return usersResponse[index]
    }
}
