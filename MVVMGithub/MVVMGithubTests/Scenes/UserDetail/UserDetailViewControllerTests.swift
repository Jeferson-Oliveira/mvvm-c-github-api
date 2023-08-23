import Foundation
import Nimble
import Nimble_Snapshots
import UIKit

@testable import MVVMGithub

class UserDetailViewControllerTests: XCTestCase {
    var sut: UserDetailViewController?
    let mockService = GithubUsersServiceMock()
    
    override func setUp() {
        UIImageView.imageFronUrlProvider = MockUrlImageProvider()
        let coordinator = GithubUsersCoordinator(on: UINavigationController())
        let viewModel = UserDetailViewModel(userToDetail: .mock(),
                                            githubService: mockService,
                                            coordinator: coordinator)
        sut = UserDetailViewController(viewModel: viewModel)
        viewModel.displayDelegate = sut
    }
    
    override func tearDown() {
        mockService.shouldReturnSucess = true
    }
    
    func testViewWithCorrectState() {
        let _ = sut?.view
        
        let sizes = ["SmallSize": CGSize(width: 300, height: 700),
        "MediumSize": CGSize(width: 400, height: 900),
        "LargeSize": CGSize(width: 500, height: 1200)]

        //expect(self.sut) == recordSnapshot(sizes: sizes)
        expect(self.sut) == snapshot(sizes: sizes)
    }
}
