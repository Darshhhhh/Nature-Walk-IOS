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
    func login(email: String, password: String) {
        if let match = User.demoUsers.first(where: {
            $0.email == email && $0.password == password
        }) {
            currentUser = match
            isAuthenticated = true
        } else {
            // Clear state on failure
            currentUser = nil
            isAuthenticated = false
        }
    }
    // MARK: - LogOutHandler()
    func logout() {
        currentUser = nil
        isAuthenticated = false
    }
}
