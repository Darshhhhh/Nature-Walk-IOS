//
//  MainTabView.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-11.
//


import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var auth: AuthHandler
    @EnvironmentObject var persistence: PersistenceService

    var body: some View {
        TabView {
            NavigationView {
                SessionsListView()
            }
            .tabItem {
                Label("Walks", systemImage: "leaf.arrow.circlepath")
            }

            NavigationView {
                FavoritesView()
            }
            .tabItem {
                Label("Favorites", systemImage: "heart")
            }

            Button(role: .destructive) {
                auth.logout(persistence: persistence) 
            } label: {
                Label("Log Out", systemImage: "arrow.backward.square")
            }
            .tabItem {
                Label("Account", systemImage: "person.crop.circle")
            }
        }
    }
}
