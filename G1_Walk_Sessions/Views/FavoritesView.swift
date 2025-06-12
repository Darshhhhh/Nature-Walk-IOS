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

    var favoriteSessions: [Session] {
        sessions.sessions.filter { persistence.isFavorite($0) }
    }

    var body: some View {
        if favoriteSessions.isEmpty {
            Text("No favorites yet.").italic()
        } else {
            List(favoriteSessions) { session in
                NavigationLink(destination: SessionDetailView(session: session)) {
                    Text(session.title)
                }
            }
            .navigationTitle("Favorites")
        }
       
    }
}
