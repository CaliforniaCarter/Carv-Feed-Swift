//
//  SessionCard.swift
//  Carv-Feed
//
//  Main feed card component for ski sessions
//

import SwiftUI

struct SessionCard: View {
    let session: SkiSession
    @State private var isLiked: Bool
    @State private var likeCount: Int
    @State private var showComments = false
    @Environment(\.theme) private var theme
    
    init(session: SkiSession) {
        self.session = session
        self._isLiked = State(initialValue: session.isLiked)
        self._likeCount = State(initialValue: session.likeCount)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.lg) {
            // Header: User info
            userHeader
            
            // Session title and description
            sessionInfo
            
            // Route visualization
            RouteMapView(route: session.route)
            
            // Ski:IQ Badge
            HStack {
                SkiIQBadge(score: session.skiIQ)
                Spacer()
            }
            
            // Performance metrics
            MetricsGrid(session: session)
            
            // Photos (if any)
            if !session.photoURLs.isEmpty {
                photoCarousel
            }
            
            Divider()
                .background(Color.token(theme.tokens.components.dividerInContainer.light, dark: theme.tokens.components.dividerInContainer.dark))
            
            // Interaction bar (likes, comments)
            interactionBar
        }
        .padding(theme.spacing.lg)
        .background(
            RoundedRectangle(cornerRadius: theme.spacing.radiusMedium)
                .fill(Color.token(theme.tokens.background.container.light, dark: theme.tokens.background.container.dark))
        )
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        .sheet(isPresented: $showComments) {
            CommentSheet(isPresented: $showComments, comments: session.comments)
        }
    }
    
    // MARK: - Subviews
    
    private var userHeader: some View {
        HStack(spacing: theme.spacing.md) {
            // Avatar
            Circle()
                .fill(Color.token(theme.tokens.background.emptyProfile.light, dark: theme.tokens.background.emptyProfile.dark))
                .frame(width: 44, height: 44)
                .overlay(
                    Text(session.user.name.prefix(1))
                        .carvTypography(.header, color: theme.tokens.text.header)
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(session.user.name)
                    .carvTypography(.header, color: theme.tokens.text.header)
                
                HStack(spacing: theme.spacing.xs) {
                    Text(session.resort)
                        .carvTypography(.caption, color: theme.tokens.text.label)
                    
                    Text("•")
                        .carvTypography(.caption, color: theme.tokens.text.label)
                    
                    Text(session.date, style: .relative)
                        .carvTypography(.caption, color: theme.tokens.text.label)
                }
            }
            
            Spacer()
            
            // More options button
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 16))
                    .foregroundColor(.token(theme.tokens.icon.ui.light, dark: theme.tokens.icon.ui.dark))
            }
        }
    }
    
    private var sessionInfo: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            Text(session.title)
                .carvTypography(.title3, color: theme.tokens.text.header)
            
            Text(session.description)
                .carvTypography(.body, color: theme.tokens.text.body)
                .lineLimit(3)
            
            HStack(spacing: theme.spacing.xs) {
                Image(systemName: "location.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.token(theme.tokens.icon.muted.light, dark: theme.tokens.icon.muted.dark))
                
                Text(session.location)
                    .carvTypography(.caption, color: theme.tokens.text.label)
                
                Text("•")
                    .carvTypography(.caption, color: theme.tokens.text.label)
                
                Text(session.conditions)
                    .carvTypography(.caption, color: theme.tokens.text.label)
            }
        }
    }
    
    private var photoCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: theme.spacing.md) {
                ForEach(session.photoURLs, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: theme.spacing.radiusSmall)
                        .fill(Color.token(theme.tokens.background.subContainer.light, dark: theme.tokens.background.subContainer.dark))
                        .frame(width: 200, height: 150)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 40))
                                .foregroundColor(.token(theme.tokens.icon.muted.light, dark: theme.tokens.icon.muted.dark))
                        )
                }
            }
        }
    }
    
    private var interactionBar: some View {
        HStack(spacing: theme.spacing.xl2) {
            // Like button
            Button(action: toggleLike) {
                HStack(spacing: theme.spacing.xs) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 20))
                        .foregroundColor(isLiked ?
                            .red :
                            .token(theme.tokens.icon.ui.light, dark: theme.tokens.icon.ui.dark)
                        )
                    
                    if likeCount > 0 {
                        Text("\(likeCount)")
                            .carvTypography(.subHeader, color: theme.tokens.text.body)
                    }
                }
            }
            
            // Comment button
            Button(action: { showComments = true }) {
                HStack(spacing: theme.spacing.xs) {
                    Image(systemName: "bubble.left")
                        .font(.system(size: 20))
                        .foregroundColor(.token(theme.tokens.icon.ui.light, dark: theme.tokens.icon.ui.dark))
                    
                    if !session.comments.isEmpty {
                        Text("\(session.comments.count)")
                            .carvTypography(.subHeader, color: theme.tokens.text.body)
                    }
                }
            }
            
            Spacer()
            
            // Share button
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 20))
                    .foregroundColor(.token(theme.tokens.icon.ui.light, dark: theme.tokens.icon.ui.dark))
            }
        }
    }
    
    // MARK: - Actions
    
    private func toggleLike() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isLiked.toggle()
            likeCount += isLiked ? 1 : -1
        }
    }
}

#Preview {
    let mockSession = SkiSession(
        user: User(name: "Sarah Chen", abilityLevel: .expert),
        title: "Epic Powder Day! 🎿",
        description: "Best conditions of the season. Fresh powder all day on Blackcomb.",
        resort: "Whistler Blackcomb",
        location: "British Columbia, Canada",
        date: Date().addingTimeInterval(-86400),
        conditions: "Powder, 30cm fresh snow",
        skiIQ: 92,
        distance: 42.5,
        verticalDescent: 8420,
        duration: 6 * 3600 + 15 * 60,
        maxSpeed: 78.3,
        avgSpeed: 32.1,
        totalTurns: 1247,
        route: (0..<100).map { i in
            RoutePoint(
                latitude: 50.0 + Double(i) * 0.0001,
                longitude: -122.0 + Double(i) * 0.0002,
                elevation: 2000 - Double(i) * 10
            )
        },
        photoURLs: ["photo1", "photo2"],
        likeCount: 47,
        isLiked: false,
        comments: [
            Comment(user: User(name: "Marcus", abilityLevel: .advanced), text: "Awesome! 🎿"),
            Comment(user: User(name: "Emma", abilityLevel: .intermediate), text: "Looks amazing!")
        ]
    )
    
    return ScrollView {
        SessionCard(session: mockSession)
            .padding()
    }
    .background(Color.token(Theme.shared.tokens.background.body.light, dark: Theme.shared.tokens.background.body.dark))
    .withTheme()
}
