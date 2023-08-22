import UIKit

class BaseViewController: UIViewController {
    var loadingView = LoadingView()
    
    func showLoadingView() {
        view.addSubview(loadingView)
        loadingView.fitAllConstraints(on: view)
    }
    
    func hideLoadingView() {
        loadingView.removeFromSuperview()
    }
    
    func presentError(message: String, tryAgainCallback: @escaping () -> Void) {
        let alertViewController = UIAlertController(title: "warning".localizable(), message: message, preferredStyle: .actionSheet)
        alertViewController.addAction(.init(title: "tryAgain".localizable(), style: .default, handler: {_ in
            alertViewController.dismiss(animated: true)
            tryAgainCallback()
        }))
        alertViewController.addAction(.init(title: "ok".localizable(), style: .destructive))
        present(alertViewController, animated: true)
    }
}
