import Foundation
import Combine
@testable import lumenoTakeHome
@MainActor
final class MockProfileViewModel: ObservableObject {
    var objectWillChange: ObservableObjectPublisher
    
    var mockData: Data?
    var mockError: Error?
    
    init(objectWillChange: ObservableObjectPublisher, mockData: Data? = nil, mockError: Error? = nil) {
        self.objectWillChange = objectWillChange
        self.mockData = mockData
        self.mockError = mockError
    }
    
    func getProfile() async throws -> Profile {
        if let error = mockError {
            throw error
        }
        
        guard let data = mockData else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(ProfileResponse.self, from: data)
        guard let first = decoded.results.first else {
            throw URLError(.cannotParseResponse)
        }
        return first
    }
}
