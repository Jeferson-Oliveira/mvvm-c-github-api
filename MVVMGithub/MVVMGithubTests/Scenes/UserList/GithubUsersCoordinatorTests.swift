import Foundation
import SafariServices.SFSafariViewController
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
    
    func testRouterToDetail() {
        sut?.router(to: .detail(.mock()))
        XCTAssertEqual(navControllerSpy.pushCalled, true)
        XCTAssertTrue(navControllerSpy.pushedViewController is UserDetailViewController)
    }
    
    func testRouterToRepoUrl() {
        guard let url = URL(string: "https://github.com/torvalds/libdc-for-dirk") else { return }
        sut?.router(to: .repoUrl(url))
        XCTAssertEqual(navControllerSpy.pushCalled, true)
        XCTAssertTrue(navControllerSpy.pushedViewController is SFSafariViewController)
    }
}

