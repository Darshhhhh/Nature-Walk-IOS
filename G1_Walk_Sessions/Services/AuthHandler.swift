//
//  AuthHandler.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-08.
//

import Foundation
import Combine

final class AuthHandler: ObservableObject {

    @Published private(set) var isAuthenticated = false
    @Published private(set) var currentUser: User?

    // MARK: - LogInHandler()
    func login(email: String, password: String, persistence: PersistenceService? = nil) {
        if let match = User.demoUsers.first(where: {
            $0.email == email && $0.password == password
        }) {
            currentUser = match
            isAuthenticated = true
            persistence?.setCurrentUser(email: email)
        } else {
            currentUser = nil
            isAuthenticated = false
        }
    }

    func logout(persistence: PersistenceService? = nil) {
        persistence?.saveFavorites()
        currentUser = nil
        isAuthenticated = false
        persistence?.clearSavedCredentials()
        
    }
}
