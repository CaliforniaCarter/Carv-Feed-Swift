//
//  SkiSession.swift
//  Carv-Feed
//
//  Core ski session model
//

import Foundation
import CoreLocation

struct SkiSession: Identifiable, Codable {
    let id: UUID
    let user: User
    let title: String
    let description: String
    let resort: String
    let location: String
    let date: Date
    let conditions: String
    
    // Performance metrics
    let skiIQ: Int
    let distance: Double  // km
    let verticalDescent: Double  // meters
    let duration: TimeInterval  // seconds
    let maxSpeed: Double  // km/h
    let avgSpeed: Double  // km/h
    let totalTurns: Int
    
    // Route data (simplified coordinates for visualization)
    let route: [RoutePoint]
    
    // Optional photos
    let photoURLs: [String]
    
    // Social
    var likeCount: Int
    var isLiked: Bool
    var comments: [Comment]
    
    init(
        id: UUID = UUID(),
        user: User,
        title: String,
        description: String,
        resort: String,
        location: String,
        date: Date,
        conditions: String,
        skiIQ: Int,
        distance: Double,
        verticalDescent: Double,
        duration: TimeInterval,
        maxSpeed: Double,
        avgSpeed: Double,
        totalTurns: Int,
        route: [RoutePoint],
        photoURLs: [String] = [],
        likeCount: Int = 0,
        isLiked: Bool = false,
        comments: [Comment] = []
    ) {
        self.id = id
        self.user = user
        self.title = title
        self.description = description
        self.resort = resort
        self.location = location
        self.date = date
        self.conditions = conditions
        self.skiIQ = skiIQ
        self.distance = distance
        self.verticalDescent = verticalDescent
        self.duration = duration
        self.maxSpeed = maxSpeed
        self.avgSpeed = avgSpeed
        self.totalTurns = totalTurns
        self.route = route
        self.photoURLs = photoURLs
        self.likeCount = likeCount
        self.isLiked = isLiked
        self.comments = comments
    }
}

struct RoutePoint: Codable, Equatable {
    let latitude: Double
    let longitude: Double
    let elevation: Double  // meters
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

// MARK: - Helpers

extension SkiSession {
    var formattedDuration: String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
    
    var formattedDistance: String {
        String(format: "%.1f km", distance)
    }
    
    var formattedVertical: String {
        String(format: "%.0f m", verticalDescent)
    }
    
    var formattedMaxSpeed: String {
        String(format: "%.1f km/h", maxSpeed)
    }
    
    var formattedAvgSpeed: String {
        String(format: "%.1f km/h", avgSpeed)
    }
    
    var skiIQBadgeType: SkiIQBadgeType {
        switch skiIQ {
        case 90...100:
            return .mountainGoat
        case 80..<90:
            return .grimRipper
        case 1..<80:
            return .default
        default:
            return .empty
        }
    }
}

enum SkiIQBadgeType {
    case mountainGoat
    case grimRipper
    case `default`
    case empty
}
