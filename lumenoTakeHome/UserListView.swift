//
//  UserListView.swift
//  lumenoTakeHome
//
//  Created by Marcus Ganz on 2025-10-17.
//
import Foundation
import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel =  UserListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.Users, id: \.self) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        HStack {
                            AsyncImage(url: URL(string: user.picture.medium)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }.frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(user.name.first) \(user.name.last)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text("\(user.location.city), \(user.location.country)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onAppear() {
                        if user == viewModel.Users.last {
                            Task {
                                await self.viewModel.initUsers()
                            }
                        }
                    }
                }
            }
            .refreshable {
                viewModel.Users.removeAll()
                Task {
                    await viewModel.initUsers()
                }
            }
            .navigationTitle("Users")
            .onAppear {
                if self.viewModel.Users.isEmpty {
                    Task {
                        await self.viewModel.initUsers()
                    }
                }
            }
        }
    }
}
