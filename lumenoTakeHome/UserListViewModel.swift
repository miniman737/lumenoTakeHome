//
//  UserListViewModel.swift
//  lumenoTakeHome
//
//  Created by Marcus Ganz on 2025-10-17.
//

import Foundation
import Combine

protocol UserListModel {
    var Users: [Profile] { get }
    func initUsers() async
}


final class UserListViewModel: UserListModel, ObservableObject  {
    @Published var Users: [Profile]
    @Published var isLoading: Bool = false
    
    init() {
        self.Users = []
        self.isLoading = false
    }
    
    func getUsers() async throws -> [Profile] {
        guard let url: URL = URL(string: "https://randomuser.me/api/?results=20") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try JSONDecoder().decode(ProfileResponse.self, from: data)
        
        guard decoded.results.first != nil else {
            throw URLError(.cannotParseResponse)
        }
        return decoded.results
    }
    
    func initUsers() async {
        isLoading = true
        do {
            let temp = try await getUsers()
            self.Users.append(contentsOf: temp)
        } catch {
            print(error)
        }
        isLoading = false
    }

}
