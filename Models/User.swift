//
//  User.swift
//  Carv-Feed
//
//  User model
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let name: String
    let avatarURL: String?
    let abilityLevel: AbilityLevel
    
    enum AbilityLevel: String, Codable, CaseIterable {
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
        case expert = "Expert"
    }
    
    init(id: UUID = UUID(), name: String, avatarURL: String? = nil, abilityLevel: AbilityLevel) {
        self.id = id
        self.name = name
        self.avatarURL = avatarURL
        self.abilityLevel = abilityLevel
    }
}
