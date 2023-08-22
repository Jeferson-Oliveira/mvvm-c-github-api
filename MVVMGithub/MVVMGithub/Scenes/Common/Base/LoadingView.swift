import Foundation
import UIKit

class LoadingView: UIView {

    private var stackView = UIStackView()
    var activityIndicatorView = UIActivityIndicatorView(style: .medium)
    var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        setupStackView()
    }

    private func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        setupActivityIndicatorView()
        setupTextLabel()
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    private func setupActivityIndicatorView() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }

    private func setupTextLabel() {
        stackView.addArrangedSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "loading".localizable()
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 1
    }
    
}
