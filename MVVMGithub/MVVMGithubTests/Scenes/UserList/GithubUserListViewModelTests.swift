import Foundation
import XCTest

@testable import MVVMGithub

class GithubUserListViewModelTests: XCTestCase {
    
    var sut: GithubUsersListViewModel?
    var serviceMock = GithubUsersServiceMock()
    var coordinatorSpy = GithubUsersCoordinatorSpy(on: UINavigationControllerSpy())
    var userListDisplayMock = UserListDisplayDelegateSpy()
    
    override func setUp() {
        serviceMock = GithubUsersServiceMock()
        coordinatorSpy = GithubUsersCoordinatorSpy(on: UINavigationControllerSpy())
        userListDisplayMock = UserListDisplayDelegateSpy()
        
        sut = GithubUsersListViewModel(githubService: serviceMock, coordinator: coordinatorSpy)
        sut?.displayDelegate = userListDisplayMock
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testGetUsersSucessCall() {
        serviceMock.shouldReturnSucess = true
        
        sut?.getUsers()
        
        XCTAssertTrue(serviceMock.getUsersCalled)
        XCTAssertTrue(userListDisplayMock.loadingCalled)
        XCTAssertTrue(userListDisplayMock.usersLoadedCalled)
        XCTAssertFalse(userListDisplayMock.errorCalled)
    }
    
    func testGetUsersWithErrorCall() {
        serviceMock.shouldReturnSucess = false
        
        sut?.getUsers()
        
        XCTAssertTrue(serviceMock.getUsersCalled)
        XCTAssertTrue(userListDisplayMock.loadingCalled)
        XCTAssertTrue(userListDisplayMock.errorCalled)
        XCTAssertFalse(userListDisplayMock.usersLoadedCalled)

    }
    
    func testGetUsersCountAndIndex() {
        let mockListUsers: [User] = User.mock()
        serviceMock.shouldReturnSucess = true
        
        sut?.getUsers()
        
        XCTAssertEqual(mockListUsers.count, sut?.getUsersCount())
        XCTAssertEqual(mockListUsers[0].id, sut?.getUserFronIndex(index: 0).id)
    }
    
    func testGoToDetailAction() {
        serviceMock.shouldReturnSucess = true
        
        sut?.getUsers()
        sut?.detailUser(index: 0)
        
        XCTAssertTrue(coordinatorSpy.routerToDetailsCalled)
    }
    
    func testFilterAction() {
        serviceMock.shouldReturnSucess = true
        let mockedUsers: [User] = User.mock()
        sut?.getUsers()
        
        // Assert initial list state
        XCTAssertEqual(mockedUsers.count, sut?.getUsersCount())

        sut?.filterUsers(name: "user3")
        
        // Assert filtered list state
        XCTAssertNotEqual(mockedUsers.count, sut?.getUsersCount())
        XCTAssertEqual(sut?.getUsersCount(), 1)
        
        sut?.filterUsers(name: .empty)
        
        // Assert reset list state
        XCTAssertEqual(mockedUsers.count, sut?.getUsersCount())
    }
}

// MARK: Test Doubles

class UserListDisplayDelegateSpy: UserListDisplayDelegate {
    var loadingCalled = false
    var errorCalled = false
    var usersLoadedCalled = false
    
    func didUpdateViewState(state: UserListViewState) {
        switch state {
        case .error:
            errorCalled = true
        case .loading:
            loadingCalled = true
        case .usersLoaded:
            usersLoadedCalled = true
        }
    }
}

class GithubUsersCoordinatorSpy: GithubUsersCoordinator {
    var routerToDetailsCalled = false
    var routerToRepoUrlCalled = false

    override func router(to: GithubUsersCoordinatorRouterPath) {
        switch to {
        case .detail:
            routerToDetailsCalled = true
        case .repoUrl(_):
            routerToRepoUrlCalled = true
        }
    }
}
