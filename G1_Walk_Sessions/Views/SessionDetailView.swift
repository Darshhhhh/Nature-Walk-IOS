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
    @Environment(\.openURL) private var openURL
    
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var showUnfavoriteAlert = false
    let phoneNumber = "1234567890"
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Image carousel
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
                    
                    // Session details
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
                    
                    // Call guide button – opens the dialer with number pre‐populated
                    Button("Call \(session.guideName)") {
                        guard let url = URL(string: "tel://\(session.contactPhone)"),
                              UIApplication.shared.canOpenURL(url) else {
                            // In SwiftUI you might show an alert via state binding instead
                            print("Cannot make phone calls on this device. \(session.contactPhone)")
                            return
                        }
                        UIApplication.shared.open(url)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    // Favorite / Unfavorite button
                    Button {
                        if persistence.isFavorite(session) {
                            showUnfavoriteAlert = true
                        } else {
                            toggleFavorite()
                        }
                    } label: {
                        Label(
                            persistence.isFavorite(session) ? "Unfavorite" : "Add to Favorites",
                            systemImage: persistence.isFavorite(session) ? "heart.slash" : "heart"
                        )
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom)
                    
                    // Share
                    // Number name price
                    let shareText = "\(session.title) - $\(String(format: "%.2f", session.price)) per person and Contact \(session.contactPhone) for register for the walk!"
                    ShareLink(item: shareText) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle(session.title)
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showUnfavoriteAlert) {
                Alert(
                    title: Text("Remove from Favorites?"),
                    message: Text("Are you sure you want to remove this session from your favorites?"),
                    primaryButton: .destructive(Text("Remove")) {
                        toggleFavorite()
                    },
                    secondaryButton: .cancel()
                )
            }
            
            // Toast at bottom
            if showToast {
                VStack {
                    Spacer()
                    Text(toastMessage)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .padding(.bottom, 24)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
    }
    
    private func toggleFavorite() {
        persistence.toggleFavorite(session)
        let isFav = persistence.isFavorite(session)
        toastMessage = isFav ? "Added to Favorites" : "Removed from Favorites"
        withAnimation { showToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation { showToast = false }
        }
    }
}
