import Foundation
import XCTest

@testable import MVVMGithub

class RepositoryCellTests: XCTestCase {
    
    var sut: UserRepositoryCell?
    
    override func setUp() {
        sut = UserRepositoryCell(style: .default, reuseIdentifier: UserCell.identifier)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testCellSetupMethod() {
        let mock: UserRepository = .mock()
        sut?.updateCell(item: mock)
        XCTAssertEqual(sut?.nameLabel.text, mock.name)
        XCTAssertEqual(sut?.descriptionLabel.text, mock.repoDescription)
    }
    
    func testCellPrepareForReuseMethot() {
        let mock: UserRepository = .mock()
        sut?.updateCell(item: mock)
        sut?.prepareForReuse()
        XCTAssertEqual(sut?.nameLabel.text, .empty)
        XCTAssertEqual(sut?.descriptionLabel.text, .empty)
    }
}
