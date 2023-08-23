import Foundation
import XCTest

@testable import MVVMGithub

class UserDetailViewModelTests: XCTestCase {
    
    var sut: UserDetailViewModel?
    var serviceMock = GithubUsersServiceMock()
    var coordinatorSpy = GithubUsersCoordinatorSpy(on: UINavigationControllerSpy())
    var userDetailDisplaySpy = UserDetailDisplayDelegateSpy()
    
    override func setUp() {
        serviceMock = GithubUsersServiceMock()
        coordinatorSpy = GithubUsersCoordinatorSpy(on: UINavigationControllerSpy())
        userDetailDisplaySpy = UserDetailDisplayDelegateSpy()
        
        sut = UserDetailViewModel(userToDetail: .mock(), githubService: serviceMock, coordinator: coordinatorSpy)
        sut?.displayDelegate = userDetailDisplaySpy
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testRequestInfo() {
        serviceMock.shouldReturnSucess = true
        
        sut?.requestDetailInfo()
        
        XCTAssertTrue(serviceMock.getUserDetailCalled)
        XCTAssertTrue(userDetailDisplaySpy.loadingCalled)
        XCTAssertTrue(userDetailDisplaySpy.userDetailLoadedCalled)
        XCTAssertTrue(userDetailDisplaySpy.repositoriesLoadedCalled)
        XCTAssertFalse(userDetailDisplaySpy.errorCalled)
    }
    
    func testRequestInfoWithErrorCall() {
        serviceMock.shouldReturnSucess = false
        
        sut?.requestDetailInfo()
        
        XCTAssertTrue(serviceMock.getUserReposCalled)
        XCTAssertTrue(userDetailDisplaySpy.loadingCalled)
        XCTAssertTrue(userDetailDisplaySpy.errorCalled)
        XCTAssertFalse(userDetailDisplaySpy.repositoriesLoadedCalled)
        XCTAssertFalse(userDetailDisplaySpy.userDetailLoadedCalled)
    }
    
    func testGetUserDetail() {
        let mock: User = .mock()
        serviceMock.shouldReturnSucess = true
        
        sut?.requestDetailInfo()
        
        XCTAssertEqual(sut?.getUserDetails()?.id, mock.id)
        XCTAssertEqual(sut?.getUserDetails()?.login, mock.login)
        XCTAssertEqual(sut?.getUserDetails()?.name, mock.name)
        XCTAssertEqual(sut?.getUserDetails()?.company, mock.company)
        XCTAssertEqual(sut?.getUserDetails()?.email, mock.email)
    }
    
    func testGetUserRepos() {
        let mockRepositories: [UserRepository] = UserRepository.mock()
        serviceMock.shouldReturnSucess = true
        
        sut?.requestDetailInfo()
        
        XCTAssertEqual(sut?.getUserRepositories().first?.name, mockRepositories.first?.name)
        XCTAssertTrue(sut?.getUserRepositories().count ?? .zero > .zero)
    }
    
    func testGoToRepoUrl() {
        serviceMock.shouldReturnSucess = true
        
        sut?.requestDetailInfo()
        sut?.goToRepoUrl(index: 0)
        
        XCTAssertTrue(coordinatorSpy.routerToRepoUrlCalled)
    }
}

// MARK: Test Doubles

class UserDetailDisplayDelegateSpy: UserDetailDisplayDelegate {
    var loadingCalled = false
    var errorCalled = false
    var userDetailLoadedCalled = false
    var repositoriesLoadedCalled = false
    func didUpdateViewState(state: UserDetailViewState) {
        switch state {
        case .error:
            errorCalled = true
        case .loading:
            loadingCalled = true
        case .userDetailLoaded:
            userDetailLoadedCalled = true
        case .repositoriesLoaded:
            repositoriesLoadedCalled = true
        }
    }
}
