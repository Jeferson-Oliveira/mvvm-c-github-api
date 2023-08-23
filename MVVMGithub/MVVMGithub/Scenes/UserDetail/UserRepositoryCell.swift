
import UIKit

class UserRepositoryCell: UITableViewCell {
    
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 18)
        return nameLabel
    }()
    
    var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .white
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 3
        return descriptionLabel
    }()
    
    var dotLabel: UILabel = {
        let dotLabel = UILabel()
        dotLabel.textColor = .white
        dotLabel.translatesAutoresizingMaskIntoConstraints = false
        dotLabel.font = .systemFont(ofSize: 18)
        dotLabel.text = "·"
        return dotLabel
    }()
    
    var labelsStackView: UIStackView = {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelsStackView
    }()
    
    static let identifier = "UserRepositoryCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = .empty
        descriptionLabel.text = .empty
    }
    
    func updateCell(item: UserRepository) {
        self.nameLabel.text = item.name
        self.descriptionLabel.text = item.repoDescription
    }
}

extension UserRepositoryCell: ViewConfiguration {
    func setup() {
        contentView.backgroundColor = .black
        buildViewHierarchy()
        setupConstraints()
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(dotLabel)
        contentView.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dotLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dotLabel.widthAnchor.constraint(equalToConstant: 8),
            dotLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            labelsStackView.leadingAnchor.constraint(equalTo: dotLabel.trailingAnchor, constant: 8),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
