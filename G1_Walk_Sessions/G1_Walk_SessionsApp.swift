//
//  G1_Walk_SessionsApp.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-08.
//

import SwiftUI

@main
struct G1_Walk_SessionsApp: App {
    @StateObject private var authService = AuthHandler()
    @StateObject private var persistence = PersistenceService()
    @StateObject private var sessionService = SessionService()
    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                MainTabView()
                    .environmentObject(authService)
                    .environmentObject(sessionService)
                    .environmentObject(persistence)
            } else {
                LoginView()
                    .environmentObject(authService)
                    .environmentObject(persistence)
            }
        }
    }
}
