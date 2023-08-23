import Foundation
import SafariServices
import UIKit

enum GithubUsersCoordinatorRouterPath {
    case detail(User)
    case repoUrl(URL)
}

protocol GithubUsersCoordinatorProtocol {
    func start()
    func router(to: GithubUsersCoordinatorRouterPath)
}

class GithubUsersCoordinator: GithubUsersCoordinatorProtocol {
    private let navigationController: UINavigationController
    
    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = GithubUsersListViewModel(coordinator: self)
        let viewController = GithubUsersListViewController(viewModel: viewModel)
        viewModel.displayDelegate = viewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func router(to: GithubUsersCoordinatorRouterPath) {
        switch to {
        case .detail(let model):
            let viewModel = UserDetailViewModel(userToDetail: model, coordinator: self)
            let viewController = UserDetailViewController(viewModel: viewModel)
            viewModel.displayDelegate = viewController
            navigationController.pushViewController(viewController, animated: true)
        case .repoUrl(let url):
            let viewController = SFSafariViewController(url: url)
            navigationController.pushViewController(viewController, animated: true)
        }
        
    }
}
