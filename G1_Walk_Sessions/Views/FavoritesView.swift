//
//  FavoritesView.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-11.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var sessions: SessionService
    @EnvironmentObject var persistence: PersistenceService

    @State private var showClearAlert = false

    private var favoriteSessions: [Session] {
        sessions.sessions.filter { persistence.isFavorite($0) }
    }

    var body: some View {
        Group {
            if favoriteSessions.isEmpty {
                Text("No favorites yet.")
                    .italic()
                    .padding()
            } else {
                List(favoriteSessions) { session in
                    NavigationLink(destination: SessionDetailView(session: session)) {
                        Text(session.title)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Favorites")
        .toolbar {
            // Show "Clear All" button only when there are favorites
            ToolbarItem(placement: .navigationBarTrailing) {
                if !favoriteSessions.isEmpty {
                    Button("Clear All") {
                        showClearAlert = true
                    }
                }
            }
        }
        .alert("Remove All Favorites?", isPresented: $showClearAlert) {
            Button("Remove All", role: .destructive) {
                // Toggle off each favorite
                favoriteSessions.forEach { persistence.toggleFavorite($0) }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to remove all sessions from your favorites?")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FavoritesView()
                .environmentObject(SessionService())
                .environmentObject(PersistenceService())
        }
    }
}
