import Foundation
import XCTest

@testable import MVVMGithub

class GithubUsersCoordinatorTests: XCTestCase {
    
    var sut: GithubUsersCoordinator?
    var navControllerSpy: UINavigationControllerSpy = UINavigationControllerSpy()
    
    override func setUp() {
        navControllerSpy = UINavigationControllerSpy()
        sut = GithubUsersCoordinator(on: navControllerSpy)
    }
    
    override func tearDown() {
        sut = nil
        navControllerSpy.reset()
    }
    
    func testStartCoordinator() {
        sut?.start()
        XCTAssertEqual(navControllerSpy.pushCalled, true)
        XCTAssertTrue(navControllerSpy.pushedViewController is GithubUsersListViewController)
    }
    
    func testRouter() {
        //sut?.router(to: .detail(.mock()))
        //XCTAssertEqual(navControllerSpy.presentCalled, true)
        //XCTAssertTrue(navControllerSpy.pushedViewController is GithubUsersListViewController)
    }
}

