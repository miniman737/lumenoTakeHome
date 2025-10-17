//
//  ProfileViewModel.swift
//  lumenoTakeHome
//
//  Created by Marcus Ganz on 2025-10-16.
//

import Foundation
import Combine

protocol ProfileViewModelModel {
    var Profile: Profile? { get }
    func initProfile() async
}


final class ProfileViewModel: ProfileViewModelModel, ObservableObject  {
    @Published var Profile: Profile?
    @Published var isLoading: Bool = false
    
    init(Profile: Profile? = nil) {
        self.Profile = Profile
        self.isLoading = false
    }
    
    func getProfile() async throws -> Profile {
        guard let url: URL = URL(string: "https://randomuser.me/api/") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try JSONDecoder().decode(ProfileResponse.self, from: data)
        
        guard let first = decoded.results.first else {
            throw URLError(.cannotParseResponse)
        }
        return first
    }
    
    func initProfile() async {
        isLoading = true
        do {
            Profile = try await getProfile()
        } catch {
            print(error)
        }
        isLoading = false
    }

}
