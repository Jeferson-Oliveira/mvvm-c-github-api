import Foundation

extension String {
    static let empty = ""
    
    func localizable() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
