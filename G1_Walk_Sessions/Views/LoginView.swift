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
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "leaf.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)
                    .padding(.top, 40)

                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    SecureField("Password", text: $password)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                Toggle("Remember Me", isOn: $storage.rememberMe)
                    .padding(.horizontal)

                Button(action: {
                    if email.isEmpty || password.isEmpty {
                        errorMessage = "Email and Password fields cannot be empty."
                        showingError = true
                        return
                    }

                    auth.login(email: email, password: password)
                    if auth.isAuthenticated {
                        if storage.rememberMe {
                            storage.savedEmail = email
                            storage.savedPassword = password
                        }
                    } else {
                        errorMessage = "Invalid email or password."
                        showingError = true
                    }
                }) {
                    Text("Log In")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .onAppear {
                if storage.rememberMe {
                    email = storage.savedEmail
                    password = storage.savedPassword
                    auth.login(email: email, password: password)

                }
            }
            .alert(isPresented: $showingError) {
                Alert(title: Text("Login Failed"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    EmptyView()
                }
            }
        }
    }
}



