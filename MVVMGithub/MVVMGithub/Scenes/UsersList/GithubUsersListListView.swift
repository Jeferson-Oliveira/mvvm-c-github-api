import Foundation
import UIKit

class GithubUsersListListView: UIView {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GithubUsersListListView: ViewConfiguration {
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        buildViewHierarchy()
        setupConstraints()
    }
    
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8),
        ])
    }
}
