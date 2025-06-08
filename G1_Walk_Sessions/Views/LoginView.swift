//
//  LoginView.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-08.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthHandler
    @EnvironmentObject var storage: PersistenceService
    @State private var email = ""
    @State private var password = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Username", text: $email)
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                Toggle("Remember Me", isOn: $storage.rememberMe)
                Button("Log In") {
                    auth.login(email: email, password: password)
                    if auth.isAuthenticated {
                        if storage.rememberMe {
                            storage.savedEmail = email
                            storage.savedPassword = password
                        }
                    } else {
                        showingError = true
                    }
                }
                .onAppear {
                    if storage.rememberMe {
                        email = storage.savedEmail
                        password = storage.savedPassword
                    }
                }
            }
        }
    }
}
