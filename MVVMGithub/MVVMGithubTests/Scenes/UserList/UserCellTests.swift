import Foundation
import XCTest

@testable import MVVMGithub

class UserCellTests: XCTestCase {
    
    var sut: UserCell?
    
    override func setUp() {
        sut = UserCell(style: .default, reuseIdentifier: UserCell.identifier)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testCellSetupMethod() {
        let userMock: User = .mock()
        sut?.updateCell(item: userMock)
        XCTAssertEqual(sut?.titleLabel.text, userMock.login)
    }
    
    func testCellPrepareForReuseMethot() {
        let userMock: User = .mock()
        sut?.updateCell(item: userMock)
        sut?.prepareForReuse()
        XCTAssertEqual(sut?.titleLabel.text, .empty)
        XCTAssertEqual(sut?.avatarImage.image, nil)
    }
}
