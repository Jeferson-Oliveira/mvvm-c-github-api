import Foundation
import UIKit

protocol UserListDisplayDelegate: AnyObject {
    func didUpdateViewState(state: UserListViewState)
}

class GithubUsersListViewController: BaseViewController {
    
    lazy var mainView: GithubUsersListListView = {
        let view = GithubUsersListListView()
        view.tableView.dataSource = self
        view.tableView.delegate = self
        return view
    }()
    
    let viewModel: GithubUsersListViewModelProtocol

    init(viewModel: GithubUsersListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUsers()
    }

}

extension GithubUsersListViewController: ViewConfiguration {
    func setup() {
        title = "users".localizable()
        buildViewHierarchy()
        setupConstraints()
    }
    
    func buildViewHierarchy() {
        view.addSubview(mainView)
    }
    
    func setupConstraints() {
        mainView.fitAllConstraints(on: view)
    }
}

extension GithubUsersListViewController: UserListDisplayDelegate {
    func didUpdateViewState(state: UserListViewState) {
        switch state {
        case .error(let message):
            self.hideLoadingView()
            self.presentError(message: message, tryAgainCallback: { [weak self] in
                self?.viewModel.getUsers()
            })
        case .usersLoaded:
            self.mainView.tableView.reloadData()
            self.hideLoadingView()
        case .loading:
            self.showLoadingView()
        }
    }
}

extension GithubUsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getUsersCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.detailUser(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else { return  UITableViewCell() }
        let user = self.viewModel.getUserFronIndex(index: indexPath.row)
        cell.updateCell(item: user)
        return cell
    }
}

