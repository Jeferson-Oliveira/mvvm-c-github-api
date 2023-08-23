import Foundation
import UIKit

@testable import MVVMGithub

class MockUrlImageProvider: ImageFromUrlProviderProtocol {
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        completion(UIImage(named: "mockImage"))
    }
}
