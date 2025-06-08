//
//  PersistenceService.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-08.
//


import Foundation

final class PersistenceService: ObservableObject {
    @Published var rememberMe: Bool {
        didSet { UserDefaults.standard.set(rememberMe, forKey: "rememberMe") }
    }
    @Published var savedEmail: String {
        didSet { UserDefaults.standard.set(savedEmail, forKey: "savedEmail") }
    }
    @Published var savedPassword: String {
        didSet { UserDefaults.standard.set(savedPassword, forKey: "savedPassword") }
    }
    @Published var favoriteSessionIDs: Set<UUID> {
        didSet { saveFavorites() }
    }

    init() {
        self.rememberMe = UserDefaults.standard.bool(forKey: "rememberMe")
        self.savedEmail = UserDefaults.standard.string(forKey: "savedEmail") ?? ""
        self.savedPassword = UserDefaults.standard.string(forKey: "savedPassword") ?? ""
        if let data = UserDefaults.standard.data(forKey: "favorites"),
           let ids = try? JSONDecoder().decode(Set<UUID>.self, from: data) {
            self.favoriteSessionIDs = ids
        } else {
            self.favoriteSessionIDs = []
        }
    }

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteSessionIDs) {
            UserDefaults.standard.set(data, forKey: "favorites")
        }
    }

    func toggleFavorite(_ session: Session) {
        if favoriteSessionIDs.contains(session.id) {
            favoriteSessionIDs.remove(session.id)
        } else {
            favoriteSessionIDs.insert(session.id)
        }
    }

    func isFavorite(_ session: Session) -> Bool {
        favoriteSessionIDs.contains(session.id)
    }
}
