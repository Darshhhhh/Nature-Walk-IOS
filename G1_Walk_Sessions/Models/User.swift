//
//  User.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-08.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: UUID
    let email: String
    let password: String
    let type: String

    static let demoUsers: [User] = [
        User(id: UUID(), email: "test@gmail.com", password: "test123", type: "User"),
        User(id: UUID(), email: "admin@gmail.com", password: "admin123",type: "Admin"),
    ]
}
