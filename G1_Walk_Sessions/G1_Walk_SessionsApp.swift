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
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(authService)
                .environmentObject(persistence)
        }
    }
}
