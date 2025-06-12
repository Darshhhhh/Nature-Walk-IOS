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
    let userName = UserDefaults.standard.string(forKey: "savedEmail") ?? ""
    @State private var showLogoutAlert = false
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
            NavigationView {
                VStack(spacing: 24) {
                    // Display current username
                    Text("Logged in as")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(userName)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    // Logout button
                    Button(role: .destructive) {
//                        auth.logout(persistence: persistence)
                        showLogoutAlert = true
                    } label: {
                        Label("Log Out", systemImage: "arrow.backward.square")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .navigationTitle("Account")
                .navigationBarTitleDisplayMode(.inline)
                .alert("Log Out", isPresented: $showLogoutAlert) {
                    Button("Yes, Log Out", role: .destructive) {
                        auth.logout(persistence: persistence)
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Are you sure you want to log out?")
                }
            }
            .tabItem {
                Label("Account", systemImage: "person.crop.circle")
            }
        }
    }
}
