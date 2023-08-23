import Foundation
import XCTest
import Alamofire

@testable import MVVMGithub

class GithubUsersServiceTests: XCTestCase {
    
    var sut: GithubUsersServiceSpy?
    
    override func setUp() {
        sut = GithubUsersServiceSpy()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testGetUsersRequest() {
        sut?.getUsers(completion: {_ in })
        
        XCTAssertEqual(sut?.requestCalled, true)
        XCTAssertEqual(sut?.methodCaled, .get)
        XCTAssertEqual(sut?.endpointCaled, "https://api.github.com/users")
    }
    
    func testGetUserDetailRequest() {
        sut?.getUser(name: "jeferson", completion: {_ in })
        
        XCTAssertEqual(sut?.requestCalled, true)
        XCTAssertEqual(sut?.methodCaled, .get)
        XCTAssertEqual(sut?.endpointCaled, "https://api.github.com/users/jeferson")
    }
}

// MARK: Test Doubles

class GithubUsersServiceSpy: GithubUsersService {
    var requestCalled = false
    var methodCaled: HTTPMethod?
    var endpointCaled: String?
    
    override func request<T>(endpoint: String,
                             method: HTTPMethod = .get,
                             parameters: Parameters? = nil,
                             completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        requestCalled = true
        methodCaled = method
        endpointCaled = endpoint
    }
}
