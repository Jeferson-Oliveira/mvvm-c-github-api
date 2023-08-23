import UIKit

protocol UserDetailDisplayDelegate: AnyObject {
    func didUpdateViewState(state: UserDetailViewState)
}

class UserDetailViewController: BaseViewController {
    
    lazy var mainView: UserDetailView = {
        let view = UserDetailView()
        view.tableView.dataSource = self
        view.tableView.delegate = self
        return view
    }()
    
    let viewModel: UserDetailViewModelProtocol

    init(viewModel: UserDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestDetailInfo()
    }

}

extension UserDetailViewController: ViewConfiguration {
    func setup() {
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

extension UserDetailViewController: UserDetailDisplayDelegate {
    func didUpdateViewState(state: UserDetailViewState) {
        switch state {
        case .error(let message):
            self.hideLoadingView()
            self.presentError(message: message, tryAgainCallback: { [weak self] in
                self?.viewModel.requestDetailInfo()
            })
        case .userDetailLoaded:
            if let url = viewModel.getUserDetails()?.avatarUrl {
                mainView.avatarImage.fromURL(from: url)
            }
            title = viewModel.getUserDetails()?.name
            mainView.nameLabel.text = viewModel.getUserDetails()?.name
            mainView.companyLabel.text = viewModel.getUserDetails()?.company
            mainView.emailLabel.text = viewModel.getUserDetails()?.email
            self.hideLoadingView()
            
        case .repositoriesLoaded:
            self.mainView.tableView.reloadData()
            self.mainView.tableView.refreshControl?.endRefreshing()
        case .loading:
            self.mainView.tableView.refreshControl?.beginRefreshing()
            self.showLoadingView()
        }
    }
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getUserRepositories().count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.goToRepoUrl(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserRepositoryCell.identifier, for: indexPath) as? UserRepositoryCell else { return  UITableViewCell() }
        let repository = self.viewModel.getUserRepositories()[indexPath.row]
        cell.updateCell(item: repository)
        return cell
    }
}

