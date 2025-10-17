import Testing
import Foundation
@testable import lumenoTakeHome
@MainActor
struct ProfileModelTests {
    @Test func testProfileDecoding_validJSON_decodesSuccessfully() throws {
        let json = """
        {
          "results": [{
            "name": { "title": "Mr", "first": "John", "last": "Doe" },
            "location": {
              "street": { "number": 123, "name": "Main St" },
              "city": "Springfield",
              "state": "IL",
              "country": "USA"
            },
            "email": "john.doe@example.com",
            "login": { "uuid": "123e4567-e89b-12d3-a456-426614174000" },
            "phone": "555-1234",
            "cell": "555-5678",
            "picture": {
              "large": "https://example.com/large.jpg",
              "medium": "https://example.com/med.jpg",
              "thumbnail": "https://example.com/thumb.jpg"
            }
          }]
        }
        """.data(using: .utf8)!
        
        let response = try JSONDecoder().decode(ProfileResponse.self, from: json)
        let profile = try #require(response.results.first)
        
        #expect(profile.name.first == "John")
        #expect(profile.name.last == "Doe")
        #expect(profile.email == "john.doe@example.com")
        #expect(profile.id.uuidString == "123E4567-E89B-12D3-A456-426614174000")
    }
    
    @Test func testProfileDecoding_invalidUUID_throwsError() throws {
        let json = """
        {
          "results": [{
            "name": { "title": "Mr", "first": "John", "last": "Doe" },
            "location": {
              "street": { "number": 123, "name": "Main St" },
              "city": "Springfield",
              "state": "IL",
              "country": "USA"
            },
            "email": "john@example.com",
            "login": { "uuid": "invalid-uuid" },
            "phone": "555-1234",
            "cell": "555-5678",
            "picture": {
              "large": "https://example.com/large.jpg",
              "medium": "https://example.com/med.jpg",
              "thumbnail": "https://example.com/thumb.jpg"
            }
          }]
        }
        """.data(using: .utf8)!
        
        #expect(throws: Error.self) {
            try JSONDecoder().decode(ProfileResponse.self, from: json)
        }
    }
    
    @Test func testProfileDecoding_missingRequiredField_throwsError() throws {
        let json = """
        {
          "results": [{
            "name": { "title": "Mr", "first": "John" },
            "location": {
              "street": { "number": 123, "name": "Main St" },
              "city": "Springfield",
              "state": "IL",
              "country": "USA"
            },
            "email": "john@example.com",
            "login": { "uuid": "123e4567-e89b-12d3-a456-426614174000" }
          }]
        }
        """.data(using: .utf8)!
        
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(ProfileResponse.self, from: json)
        }
    }
}
