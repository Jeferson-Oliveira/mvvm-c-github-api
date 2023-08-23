import UIKit

class UserCell: UITableViewCell {
    
    var avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.roundCorners(with: 20)
        return avatarImage
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    var labelsStackView: UIStackView = {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelsStackView
    }()
    
    static let identifier = "UserCell"
    
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
        avatarImage.image = nil
        titleLabel.text = .empty
    }
    
    func updateCell(item: User) {
        if let url = item.avatarUrl {
            self.avatarImage.fromURL(from: url, placeholder: UIImage(named: "no_image_icon"))
        }
        self.avatarImage.backgroundColor = .gray.withAlphaComponent(0.5)
        self.titleLabel.text = item.login
    }
}

extension UserCell: ViewConfiguration {
    func setup() {
        contentView.backgroundColor = .black
        buildViewHierarchy()
        setupConstraints()
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(avatarImage)
        contentView.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarImage.trailingAnchor.constraint(equalTo: labelsStackView.leadingAnchor, constant: -8),
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
