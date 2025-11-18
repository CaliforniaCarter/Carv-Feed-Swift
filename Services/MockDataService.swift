//
//  MockDataService.swift
//  Carv-Feed
//
//  Mock data generator for ski sessions
//  TODO: Replace with real API service
//

import Foundation

class MockDataService {
    static let shared = MockDataService()
    
    private init() {}
    
    // MARK: - Mock Users
    
    private let mockUsers: [User] = [
        User(name: "Sarah Chen", avatarURL: nil, abilityLevel: .expert),
        User(name: "Marcus Johnson", avatarURL: nil, abilityLevel: .advanced),
        User(name: "Emma Rodriguez", avatarURL: nil, abilityLevel: .intermediate),
        User(name: "Liam O'Brien", avatarURL: nil, abilityLevel: .expert),
        User(name: "Olivia Kim", avatarURL: nil, abilityLevel: .advanced),
        User(name: "Noah Anderson", avatarURL: nil, abilityLevel: .intermediate),
        User(name: "Sophia Patel", avatarURL: nil, abilityLevel: .expert),
        User(name: "Jackson Miller", avatarURL: nil, abilityLevel: .beginner)
    ]
    
    // MARK: - Generate Sessions
    
    func generateMockSessions() -> [SkiSession] {
        var sessions: [SkiSession] = []
        
        // Session 1: Epic powder day at Whistler
        sessions.append(SkiSession(
            user: mockUsers[0],
            title: "Epic Powder Day! 🎿",
            description: "Best conditions of the season. Fresh powder all day on Blackcomb.",
            resort: "Whistler Blackcomb",
            location: "British Columbia, Canada",
            date: Date().addingTimeInterval(-86400 * 1),
            conditions: "Powder, 30cm fresh snow",
            skiIQ: 92,
            distance: 42.5,
            verticalDescent: 8420,
            duration: 6 * 3600 + 15 * 60,
            maxSpeed: 78.3,
            avgSpeed: 32.1,
            totalTurns: 1247,
            route: generateRoute(complexity: .high, points: 150),
            photoURLs: ["photo1", "photo2"],
            likeCount: 47,
            isLiked: false,
            comments: generateComments(count: 5)
        ))
        
        // Session 2: Groomer session at Vail
        sessions.append(SkiSession(
            user: mockUsers[1],
            title: "Morning Groomers",
            description: "Perfect corduroy on Blue Sky Basin. Great warm-up session.",
            resort: "Vail",
            location: "Colorado, USA",
            date: Date().addingTimeInterval(-86400 * 2),
            conditions: "Groomed, sunny",
            skiIQ: 78,
            distance: 28.3,
            verticalDescent: 5240,
            duration: 4 * 3600 + 30 * 60,
            maxSpeed: 65.2,
            avgSpeed: 28.5,
            totalTurns: 892,
            route: generateRoute(complexity: .medium, points: 100),
            photoURLs: [],
            likeCount: 23,
            isLiked: true,
            comments: generateComments(count: 2)
        ))
        
        // Session 3: Backcountry at Chamonix
        sessions.append(SkiSession(
            user: mockUsers[3],
            title: "Vallée Blanche Descent",
            description: "Incredible off-piste run from Aiguille du Midi. Challenging but worth it!",
            resort: "Chamonix Mont-Blanc",
            location: "France",
            date: Date().addingTimeInterval(-86400 * 3),
            conditions: "Off-piste, variable snow",
            skiIQ: 95,
            distance: 22.1,
            verticalDescent: 2800,
            duration: 5 * 3600 + 45 * 60,
            maxSpeed: 82.7,
            avgSpeed: 18.3,
            totalTurns: 654,
            route: generateRoute(complexity: .high, points: 120),
            photoURLs: ["photo1", "photo2", "photo3"],
            likeCount: 89,
            isLiked: true,
            comments: generateComments(count: 12)
        ))
        
        // Session 4: Moguls at Jackson Hole
        sessions.append(SkiSession(
            user: mockUsers[4],
            title: "Mogul Practice",
            description: "Working on technique in the bumps. Legs are burning! 🔥",
            resort: "Jackson Hole",
            location: "Wyoming, USA",
            date: Date().addingTimeInterval(-86400 * 4),
            conditions: "Moguls, firm snow",
            skiIQ: 71,
            distance: 15.8,
            verticalDescent: 3120,
            duration: 3 * 3600 + 20 * 60,
            maxSpeed: 45.3,
            avgSpeed: 22.1,
            totalTurns: 1456,
            route: generateRoute(complexity: .medium, points: 80),
            photoURLs: [],
            likeCount: 31,
            isLiked: false,
            comments: generateComments(count: 7)
        ))
        
        // Session 5: Family day at Park City
        sessions.append(SkiSession(
            user: mockUsers[5],
            title: "Family Ski Day",
            description: "Teaching the kids on the bunny slopes. So much fun!",
            resort: "Park City",
            location: "Utah, USA",
            date: Date().addingTimeInterval(-86400 * 5),
            conditions: "Groomed, mild weather",
            skiIQ: 58,
            distance: 12.4,
            verticalDescent: 1850,
            duration: 2 * 3600 + 45 * 60,
            maxSpeed: 38.2,
            avgSpeed: 18.7,
            totalTurns: 423,
            route: generateRoute(complexity: .low, points: 60),
            photoURLs: ["photo1"],
            likeCount: 18,
            isLiked: true,
            comments: generateComments(count: 3)
        ))
        
        // Session 6: Speed run at St. Anton
        sessions.append(SkiSession(
            user: mockUsers[6],
            title: "Speed Session 💨",
            description: "Pushing limits on the Kandahar run. New personal best!",
            resort: "St. Anton am Arlberg",
            location: "Austria",
            date: Date().addingTimeInterval(-86400 * 6),
            conditions: "Icy, fast conditions",
            skiIQ: 88,
            distance: 35.7,
            verticalDescent: 6890,
            duration: 4 * 3600 + 55 * 60,
            maxSpeed: 91.4,
            avgSpeed: 35.8,
            totalTurns: 734,
            route: generateRoute(complexity: .high, points: 110),
            photoURLs: ["photo1", "photo2"],
            likeCount: 56,
            isLiked: false,
            comments: generateComments(count: 9)
        ))
        
        // Session 7: Tree skiing at Revelstoke
        sessions.append(SkiSession(
            user: mockUsers[0],
            title: "Tree Run Paradise",
            description: "Found some secret stashes in the trees. Powder pockets everywhere!",
            resort: "Revelstoke",
            location: "British Columbia, Canada",
            date: Date().addingTimeInterval(-86400 * 7),
            conditions: "Powder in trees",
            skiIQ: 85,
            distance: 31.2,
            verticalDescent: 5670,
            duration: 5 * 3600 + 10 * 60,
            maxSpeed: 62.1,
            avgSpeed: 26.4,
            totalTurns: 1089,
            route: generateRoute(complexity: .high, points: 130),
            photoURLs: [],
            likeCount: 42,
            isLiked: true,
            comments: generateComments(count: 6)
        ))
        
        // Session 8: Beginner progress at Breckenridge
        sessions.append(SkiSession(
            user: mockUsers[7],
            title: "First Green Run! 🎉",
            description: "Finally made it down a green run without falling. So proud!",
            resort: "Breckenridge",
            location: "Colorado, USA",
            date: Date().addingTimeInterval(-86400 * 8),
            conditions: "Groomed, perfect for learning",
            skiIQ: 42,
            distance: 8.3,
            verticalDescent: 980,
            duration: 2 * 3600 + 15 * 60,
            maxSpeed: 28.5,
            avgSpeed: 12.3,
            totalTurns: 287,
            route: generateRoute(complexity: .low, points: 50),
            photoURLs: ["photo1"],
            likeCount: 67,
            isLiked: true,
            comments: generateComments(count: 15)
        ))
        
        return sessions
    }
    
    // MARK: - Route Generation
    
    private func generateRoute(complexity: RouteComplexity, points: Int) -> [RoutePoint] {
        var route: [RoutePoint] = []
        
        // Base coordinates (arbitrary starting point)
        var lat = 50.0 + Double.random(in: -0.1...0.1)
        var lon = -122.0 + Double.random(in: -0.1...0.1)
        var elevation = 2000.0
        
        for i in 0..<points {
            // Vary the path based on complexity
            let latChange: Double
            let lonChange: Double
            let elevChange: Double
            
            switch complexity {
            case .low:
                latChange = Double.random(in: -0.0001...0.0001)
                lonChange = Double.random(in: -0.0002...0.0002)
                elevChange = Double.random(in: -5...0)
            case .medium:
                latChange = Double.random(in: -0.0003...0.0003)
                lonChange = Double.random(in: -0.0004...0.0004)
                elevChange = Double.random(in: -15...-2)
            case .high:
                latChange = Double.random(in: -0.0005...0.0005)
                lonChange = Double.random(in: -0.0006...0.0006)
                elevChange = Double.random(in: -25...-5)
            }
            
            lat += latChange
            lon += lonChange
            elevation += elevChange
            
            route.append(RoutePoint(latitude: lat, longitude: lon, elevation: max(elevation, 1000)))
        }
        
        return route
    }
    
    private enum RouteComplexity {
        case low, medium, high
    }
    
    // MARK: - Comment Generation
    
    private func generateComments(count: Int) -> [Comment] {
        let commentTexts = [
            "Awesome run! 🎿",
            "Looks amazing! Wish I was there.",
            "Great conditions!",
            "Nice work! 💪",
            "That's incredible!",
            "Jealous of those powder conditions!",
            "Way to go!",
            "Epic day!",
            "Love this resort!",
            "Can't wait to ski there!",
            "Those stats are impressive!",
            "Beautiful photos!",
            "Congrats! 🎉",
            "Keep it up!",
            "Inspiring session!"
        ]
        
        return (0..<min(count, commentTexts.count)).map { i in
            Comment(
                user: mockUsers.randomElement()!,
                text: commentTexts[i],
                timestamp: Date().addingTimeInterval(-Double.random(in: 3600...86400))
            )
        }
    }
}
