import UIKit

//MARK: UINavigationControllerSpy
class UINavigationControllerSpy: UINavigationController {
    var presentCalled = false
    var pushCalled = false
    
    var pushedViewController: UIViewController?
    var presentedController: UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCalled = true
        presentedController = viewControllerToPresent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushCalled = true
        pushedViewController = viewController
    }
    
    func reset() {
        presentCalled = false
        presentedController = nil
        pushCalled = false
        pushedViewController = nil
    }
}
