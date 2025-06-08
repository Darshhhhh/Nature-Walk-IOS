//
//  SessionService.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-11.
//


import Foundation
import CoreLocation

final class SessionService: ObservableObject {
    @Published private(set) var sessions: [Session] = []

    init() { loadSessions() }

    private func loadSessions() {
        // Dynamically generate or fetch from network
        sessions = [
            Session(
                id: UUID(),
                title: "Forest Trail",
                description: "A serene 5 km walk through mixed woods.",
                location: .init(latitude: 43.651070, longitude: -79.347015),
                date: Date().addingTimeInterval(3600),
                contactPhone: "555-0101"
            ),
            Session(
                id: UUID(),
                title: "Lakeside Loop",
                description: "Gentle loop along the lake edge, 3 km.",
                location: .init(latitude: 43.653908, longitude: -79.384293),
                date: Date().addingTimeInterval(7200),
                contactPhone: "555-0202"
            )
        ]
    }
}
