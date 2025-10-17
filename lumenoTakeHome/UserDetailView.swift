//
//  UserDetailView.swift
//  lumenoTakeHome
//
//  Created by Marcus Ganz on 2025-10-17.
//

import Foundation
import SwiftUI

struct UserDetailView: View {
    @State var user: Profile
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(spacing: 12) {
                    AsyncImage(url: URL(string: user.picture.large))
                        .scaledToFill()
                        .clipShape(Circle())
                    HStack {
                        Text(user.name.title)
                        Text(user.name.first)
                        Text(user.name.last)
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
                        Text(user.email)
                            .font(.body)
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(.green)
                        Text(user.phone)
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "phone.circle")
                            .foregroundColor(.orange)
                        Text(user.cell )
                        Spacer()
                    }
                    Divider()
                        .background(Color.secondary.opacity(0.5))
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.red)
                            Text("\(user.location.city), \(user.location.state)")
                            Spacer()
                        }
                        Text("\(user.location.street.number) \(user.location.street.name)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(user.location.country)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
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
            
        }
    }
}
#Preview {
    ProfileView()
}
