import Foundation

enum UserListViewState {
    case loading
    case error(String)
    case usersLoaded
}

protocol GithubUsersListViewModelProtocol {
    func getUsers()
    func filterUsers(name: String)
    func detailUser(index: Int)
    func getUsersCount() -> Int
    func getUserFronIndex(index: Int) -> User
}

class GithubUsersListViewModel: GithubUsersListViewModelProtocol {
    
    private let coordinator: GithubUsersCoordinatorProtocol
    private let githubService: GithubServiceProtocol
    private var usersResponse = [User]()
    private var filteredUsers = [User]()

    weak var displayDelegate: UserListDisplayDelegate?

    init(githubService: GithubServiceProtocol = GithubUsersService(),
         coordinator: GithubUsersCoordinatorProtocol) {
        self.githubService = githubService
        self.coordinator = coordinator
    }
    
    func getUsers() {
        self.displayDelegate?.didUpdateViewState(state: .loading)
        githubService.getUsers { result in
            switch result {
            case .success(let users):
                self.usersResponse = users
                self.filteredUsers = users
                self.displayDelegate?.didUpdateViewState(state: .usersLoaded)
            case .failure(let error):
                self.displayDelegate?.didUpdateViewState(state: .error(error.localizedDescription))
            }
        }
    }
    
    func detailUser(index: Int) {
        coordinator.router(to: .detail(getUserFronIndex(index: index)))
    }
    
    func getUsersCount() -> Int {
        return filteredUsers.count
    }
    
    func getUserFronIndex(index: Int) -> User {
        return filteredUsers[index]
    }
    
    func filterUsers(name: String) {
        if name.isEmpty {
            filteredUsers = usersResponse
        } else {
            filteredUsers = usersResponse.filter { $0.login?.lowercased().contains(name.lowercased()) ?? false }
        }
        displayDelegate?.didUpdateViewState(state: .usersLoaded)
    }
}
