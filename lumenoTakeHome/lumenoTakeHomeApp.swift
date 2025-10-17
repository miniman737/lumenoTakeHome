//
//  lumenoTakeHomeApp.swift
//  lumenoTakeHome
//
//  Created by Marcus Ganz on 2025-10-16.
//

import SwiftUI

@main
struct lumenoTakeHomeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                UserListView()
                    .tabItem {
                        Label("Users", systemImage: "person.3")
                    }
            }
        }
    }
}
