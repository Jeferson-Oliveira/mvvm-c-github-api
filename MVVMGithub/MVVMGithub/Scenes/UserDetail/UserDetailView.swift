import UIKit

class UserDetailView: UIView {
    
    let avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.roundCorners(with: 20)
        return avatarImage
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let companyLabel: UILabel = {
        let companyLabel = UILabel()
        companyLabel.textColor = .white
        companyLabel.textAlignment = .center
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        return companyLabel
    }()
    
    let emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.textColor = .white
        emailLabel.textAlignment = .center
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        return emailLabel
    }()
    
    let reposTitleLabel: UILabel = {
        let reposTitleLabel = UILabel()
        reposTitleLabel.text = "repos".localizable()
        reposTitleLabel.textColor = .white
        reposTitleLabel.textAlignment = .left
        reposTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return reposTitleLabel
    }()
    
    let labelsStackView: UIStackView = {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fillEqually
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelsStackView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserRepositoryCell.self, forCellReuseIdentifier: UserRepositoryCell.identifier)
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

extension UserDetailView: ViewConfiguration {
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        buildViewHierarchy()
        setupConstraints()
    }
    
    func buildViewHierarchy() {
        addSubview(avatarImage)
        addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(companyLabel)
        labelsStackView.addArrangedSubview(emailLabel)
        addSubview(reposTitleLabel)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.widthAnchor.constraint(equalToConstant: 90),
            avatarImage.heightAnchor.constraint(equalToConstant: 90),
            avatarImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            avatarImage.bottomAnchor.constraint(equalTo: labelsStackView.topAnchor, constant: -16),
            labelsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: reposTitleLabel.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: reposTitleLabel.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8)
        ])
    }
}
