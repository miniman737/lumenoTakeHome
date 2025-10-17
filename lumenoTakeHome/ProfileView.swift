//
//  ProfileView.swift
//  lumenoTakeHome
//
//  Created by Marcus Ganz on 2025-10-16.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(spacing: 12) {
                        AsyncImage(url: URL(string: viewModel.Profile?.picture.large ?? "https://via.placeholder.com/150"))
                            .scaledToFill()
                            .clipShape(Circle())
                        HStack {
                            Text(viewModel.Profile?.name.title ?? "Loading")
                            Text(viewModel.Profile?.name.first ?? "Loading")
                            Text(viewModel.Profile?.name.last ?? "Loading")
                        }
                        .font(.title2)
                        .fontWeight(.semibold)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(UIColor.secondarySystemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.primary.opacity(0.05), lineWidth: 1)
                    )
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.03) : Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                    .padding(.horizontal)
                    
                    // Contact card
                    VStack(spacing: 14) {
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.blue)
                            Text(viewModel.Profile?.email ?? "—")
                                .font(.body)
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "phone")
                                .foregroundColor(.green)
                            Text(viewModel.Profile?.phone ?? "—")
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "phone.circle")
                                .foregroundColor(.orange)
                            Text(viewModel.Profile?.cell ?? "—")
                            Spacer()
                        }
                        if let loc = viewModel.Profile?.location {
                            Divider()
                                .background(Color.secondary.opacity(0.5))
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundColor(.red)
                                    Text("\(loc.city), \(loc.state)")
                                    Spacer()
                                }
                                Text("\(loc.street.number) \(loc.street.name)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(loc.country)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color(UIColor.secondarySystemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.primary.opacity(0.05), lineWidth: 1)
                    )
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.03) : Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                    .padding(.horizontal)
                }
                .padding(.vertical)
                
            }.onAppear {
                Task {
                    await viewModel.initProfile()
                }
            }
            .refreshable {
                Task {
                    await viewModel.initProfile()
                }
            }
    }
}

#Preview {
    ProfileView()
}
