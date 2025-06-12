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
        let commonImages = ["P1", "P2"]

        sessions = [
            Session(
                id: UUID(),
                title: "Forest Trail",
                description: "A serene 5 km walk through mixed woods.",
                address: "123 Pine Lane, Toronto",
                date: Date().addingTimeInterval(3600),
                contactPhone: "555-0101",
                guideName: "Eco Adventures",
                rating: 5,
                price: 20.0,
                images: commonImages
            ),
            Session(
                id: UUID(),
                title: "Lakeside Loop",
                description: "Gentle 3 km loop along Lake Ontario.",
                address: "456 Lake Shore Blvd, Toronto",
                date: Date().addingTimeInterval(7200),
                contactPhone: "555-0202",
                guideName: "Toronto Nature Club",
                rating: 4,
                price: 15.0,
                images: commonImages
            ),
            Session(
                id: UUID(),
                title: "Valley Walk",
                description: "Explore scenic valleys and learn about local flora.",
                address: "789 Valley Road, Toronto",
                date: Date().addingTimeInterval(10800),
                contactPhone: "555-0303",
                guideName: "Wild Trails",
                rating: 5,
                price: 25.0,
                images: commonImages
            ),
            Session(
                id: UUID(),
                title: "Meadow Morning",
                description: "Relaxing walk through flower-covered meadows.",
                address: "101 Meadow Path, Toronto",
                date: Date().addingTimeInterval(14400),
                contactPhone: "555-0404",
                guideName: "Bloom Nature Guides",
                rating: 4,
                price: 18.0,
                images: commonImages
            ),
            Session(
                id: UUID(),
                title: "Sunset Ridge",
                description: "Evening walk with sunset views over the ridge.",
                address: "202 Ridge View, Toronto",
                date: Date().addingTimeInterval(18000),
                contactPhone: "555-0505",
                guideName: "Sunset Hikes",
                rating: 5,
                price: 22.0,
                images: commonImages
            )
        ]
    }

}
