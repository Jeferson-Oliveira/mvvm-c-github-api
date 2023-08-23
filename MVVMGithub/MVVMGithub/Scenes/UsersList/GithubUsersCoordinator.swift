import Foundation
import UIKit

enum GithubUsersCoordinatorRouterPath {
    case detail(User)
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
            // TODO: Show details
            print(model)
        }
    }
}
