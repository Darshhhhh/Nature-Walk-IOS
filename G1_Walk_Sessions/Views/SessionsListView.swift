//
//  SessionsListView.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-11.
//

import SwiftUI
import MapKit

// Simple blur background for toast messages
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct SessionsListView: View {
    @EnvironmentObject var sessions: SessionService
    @EnvironmentObject var persistence: PersistenceService

    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""

    var body: some View {
        ZStack {
            List(sessions.sessions) { session in
                NavigationLink(destination: SessionDetailView(session: session)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(session.title)
                                .font(.headline)
                            Text(session.formattedDate)
                                .font(.subheadline)
                        }
                        Spacer()
                        Button {
                            persistence.toggleFavorite(session)
                            let isFav = persistence.isFavorite(session)
                            toastMessage = isFav ? "Added to Favorites" : "Removed from Favorites"
                            withAnimation { showToast = true }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation { showToast = false }
                            }
                        } label: {
                            Image(systemName: persistence.isFavorite(session) ? "heart.fill" : "heart")
                                .foregroundColor(persistence.isFavorite(session) ? .red : .gray)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .padding(.vertical, 6)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Nature Walks")
            if showToast {
                VStack {
                    Spacer()
                    Text(toastMessage)
                        .font(.subheadline)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(BlurView(style: .systemThinMaterial))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .padding(.bottom, 24)
                }
            }
        }
    }
}

struct SessionsListView_Previews: PreviewProvider {
    static var previews: some View {
        SessionsListView()
            .environmentObject(SessionService())
            .environmentObject(PersistenceService())
    }
}
