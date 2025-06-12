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

    var currentUserEmail: String? {
        UserDefaults.standard.string(forKey: "currentUserEmail")
    }

    init() {
        self.rememberMe = UserDefaults.standard.bool(forKey: "rememberMe")
        self.savedEmail = UserDefaults.standard.string(forKey: "savedEmail") ?? ""
        self.savedPassword = UserDefaults.standard.string(forKey: "savedPassword") ?? ""

        // ✅ Use UserDefaults directly here to avoid using `self` before init
        if let email = UserDefaults.standard.string(forKey: "currentUserEmail"),
           let data = UserDefaults.standard.data(forKey: "favorites_\(email)"),
           let ids = try? JSONDecoder().decode(Set<UUID>.self, from: data) {
            self.favoriteSessionIDs = ids
        } else {
            self.favoriteSessionIDs = []
        }
    }

    private func saveFavorites() {
        guard let email = currentUserEmail else { return }
        if let data = try? JSONEncoder().encode(favoriteSessionIDs) {
            UserDefaults.standard.set(data, forKey: "favorites_\(email)")
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

    func clearSavedCredentials() {
        rememberMe = false
        savedEmail = ""
        savedPassword = ""
        UserDefaults.standard.removeObject(forKey: "currentUserEmail")
    }

    func setCurrentUser(email: String) {
        UserDefaults.standard.set(email, forKey: "currentUserEmail")
    }
}
