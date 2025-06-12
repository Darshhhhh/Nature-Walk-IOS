//
//  SessionDetailView.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-11.
//


import SwiftUI

struct SessionDetailView: View {
    let session: Session
    @EnvironmentObject var persistence: PersistenceService
    
    private var imageNames: [String] {
        
        return ["P1", "P2"]
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                TabView {
                    ForEach(session.images, id: \.self) { name in
                                   Image(name)
                                       .resizable()
                                       .scaledToFill()
                                       .frame(height: 250)
                                       .clipped()
                               }
                           }
                           .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                           .frame(height: 250)
                VStack(alignment: .leading, spacing: 8) {
                    Text(session.title)
                        .font(.title)
                        .bold()
                    
                    Text("By \(session.guideName)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("📍 Address: \(session.address)")
                        .font(.subheadline)
                    
                    Text("⭐️ Rating: \(session.rating)/5")
                    Text("💵 Price: $\(String(format: "%.2f", session.price)) per person")
                    Text("🗓 When: \(session.formattedDate)")
                    
                    Text("📝 Description:")
                        .font(.headline)
                        .padding(.top, 8)
                    
                    Text(session.description)
                        .font(.body)
                }
                .padding(.horizontal)
                
                // 📞 Call guide button
                Button("Call \(session.guideName)") {
                    if let url = URL(string: "tel://\(session.contactPhone)") {
                        UIApplication.shared.open(url)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                // ❤️ Favorite toggle
                Button {
                    persistence.toggleFavorite(session)
                } label: {
                    Label(
                        persistence.isFavorite(session) ? "Unfavorite" : "Add to Favorites",
                        systemImage: persistence.isFavorite(session) ? "heart.slash" : "heart"
                    )
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
                
                // 📤 Share button
                let shareText = "\(session.title) - $\(String(format: "%.2f", session.price)) per person"
                ShareLink(item: shareText) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(session.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
