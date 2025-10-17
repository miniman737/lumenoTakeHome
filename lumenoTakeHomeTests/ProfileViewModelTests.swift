import Testing
import Foundation
@testable import lumenoTakeHome
import Combine

@MainActor
struct ProfileViewModelTests {
    
    @Test func testGetProfile_validResponse_returnsProfile() async throws {
        let json = """
        {
          "results": [{
            "name": { "title": "Ms", "first": "Jane", "last": "Smith" },
            "location": {
              "street": { "number": 456, "name": "Oak Ave" },
              "city": "Portland",
              "state": "OR",
              "country": "USA"
            },
            "email": "jane@example.com",
            "login": { "uuid": "223e4567-e89b-12d3-a456-426614174000" },
            "phone": "555-9999",
            "cell": "555-8888",
            "picture": {
              "large": "https://example.com/large.jpg",
              "medium": "https://example.com/med.jpg",
              "thumbnail": "https://example.com/thumb.jpg"
            }
          }]
        }
        """.data(using: .utf8)!
        
        let vm = MockProfileViewModel(objectWillChange: .init())
        vm.mockData = json
        
        let profile = try await vm.getProfile()
        
        #expect(profile.name.first == "Jane")
        #expect(profile.email == "jane@example.com")
    }
    
    @Test func testGetProfile_networkError_throwsError() async throws {
        let vm = MockProfileViewModel(objectWillChange: .init())
        vm.mockError = URLError(.notConnectedToInternet)
        
        await #expect(throws: URLError.self) {
            try await vm.getProfile()
        }
    }
}
