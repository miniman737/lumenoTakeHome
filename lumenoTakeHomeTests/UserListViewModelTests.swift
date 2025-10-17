import Testing
import Foundation
@testable import lumenoTakeHome

@MainActor
struct UserListViewModelTests {
    
    @Test func testGetUsers_validResponse_returnsMultipleUsers() async throws {
        let vm = UserListViewModel()
        
        let users = try await vm.getUsers()
        
        #expect(users.count == 20)
    }
    
    private func makeMockSession(data: Data, statusCode: Int) -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        MockURLProtocol.handler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
        
        return URLSession(configuration: config)
    }
}
