//
//  FeedView.swift
//  Carv-Feed
//
//  Main feed screen with scrollable session cards
//

import SwiftUI

struct FeedView: View {
    @State private var sessions: [SkiSession] = []
    @State private var isRefreshing = false
    @Environment(\.theme) private var theme
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: theme.spacing.lg) {
                    ForEach(sessions) { session in
                        SessionCard(session: session)
                            .padding(.horizontal, theme.spacing.lg)
                    }
                }
                .padding(.vertical, theme.spacing.lg)
            }
            .background(Color.token(theme.tokens.background.body.light, dark: theme.tokens.background.body.dark))
            .navigationTitle("Carv Feed")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await refreshFeed()
            }
        }
        .onAppear {
            loadSessions()
        }
    }
    
    // MARK: - Data Loading
    
    private func loadSessions() {
        sessions = MockDataService.shared.generateMockSessions()
    }
    
    private func refreshFeed() async {
        isRefreshing = true
        
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Reload mock data
        sessions = MockDataService.shared.generateMockSessions()
        
        isRefreshing = false
    }
}

#Preview {
    FeedView()
        .withTheme()
}
