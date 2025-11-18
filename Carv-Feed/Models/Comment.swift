//
//  Comment.swift
//  Carv-Feed
//
//  Comment model for social interactions
//

import Foundation

struct Comment: Identifiable, Codable {
    let id: UUID
    let user: User
    let text: String
    let timestamp: Date
    
    init(id: UUID = UUID(), user: User, text: String, timestamp: Date = Date()) {
        self.id = id
        self.user = user
        self.text = text
        self.timestamp = timestamp
    }
}
