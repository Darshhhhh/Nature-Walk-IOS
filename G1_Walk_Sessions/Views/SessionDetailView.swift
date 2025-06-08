//
//  SessionDetailView.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-11.
//


import SwiftUI
import MapKit

struct SessionDetailView: View {
    let session: Session
    @EnvironmentObject var persistence: PersistenceService

    var body: some View {
        VStack(spacing: 16) {
            Map(coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: session.location,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            ))
            .frame(height: 200)
            Text(session.description)
                .padding()
            Text("When: \(session.formattedDate)")
            Button("Call Guide") {
                let url = URL(string: "tel://\(session.contactPhone)")!
                UIApplication.shared.open(url)
            }
            Spacer()
            Button {
                persistence.toggleFavorite(session)
            } label: {
                Label(
                    persistence.isFavorite(session) ? "Unfavorite" : "Add to Favorites",
                    systemImage: persistence.isFavorite(session) ? "heart.slash" : "heart"
                )
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle(session.title)
        .padding()
    }
}
