//
//  Session.swift
//  G1_Walk_Sessions
//
//  Created by Darsh on 2025-06-08.
//


import Foundation
import CoreLocation

struct Session: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let description: String
    let address: String
    let date: Date
    let contactPhone: String
    let guideName: String
    let rating: Int
    let price: Double
    let images: [String]

    var formattedDate: String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df.string(from: date)
    }
}

