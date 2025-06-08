//
//  SessionsListView.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-11.
//


import SwiftUI
import MapKit

struct SessionsListView: View {
    @EnvironmentObject var sessions: SessionService
    @EnvironmentObject var persistence: PersistenceService

    var body: some View {
        List(sessions.sessions) { session in
            NavigationLink(destination: SessionDetailView(session: session)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(session.title).font(.headline)
                        Text(session.formattedDate).font(.subheadline)
                    }
                    Spacer()
                    Button {
                        persistence.toggleFavorite(session)
                    } label: {
                        Image(systemName: persistence.isFavorite(session) ? "heart.fill" : "heart")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
        .navigationTitle("Nature Walks")
    }
}
