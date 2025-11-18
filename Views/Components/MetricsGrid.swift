//
//  MetricsGrid.swift
//  Carv-Feed
//
//  Performance metrics display grid
//

import SwiftUI

struct MetricsGrid: View {
    let session: SkiSession
    @Environment(\.theme) private var theme
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: theme.spacing.md) {
            MetricItem(
                icon: "arrow.up.right",
                value: session.formattedDistance,
                label: "Distance"
            )
            
            MetricItem(
                icon: "arrow.down",
                value: session.formattedVertical,
                label: "Vertical"
            )
            
            MetricItem(
                icon: "clock",
                value: session.formattedDuration,
                label: "Time"
            )
            
            MetricItem(
                icon: "speedometer",
                value: session.formattedMaxSpeed,
                label: "Max Speed"
            )
            
            MetricItem(
                icon: "gauge.medium",
                value: session.formattedAvgSpeed,
                label: "Avg Speed"
            )
            
            MetricItem(
                icon: "arrow.triangle.turn.up.right.diamond",
                value: "\(session.totalTurns)",
                label: "Turns"
            )
        }
    }
}

struct MetricItem: View {
    let icon: String
    let value: String
    let label: String
    @Environment(\.theme) private var theme
    
    var body: some View {
        VStack(spacing: theme.spacing.xs) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.token(theme.tokens.icon.ui.light, dark: theme.tokens.icon.ui.dark))
            
            Text(value)
                .carvTypography(.bodyBold, color: theme.tokens.text.header)
            
            Text(label)
                .carvTypography(.caption, color: theme.tokens.text.label)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, theme.spacing.sm)
    }
}

#Preview {
    let mockSession = SkiSession(
        user: User(name: "Test User", abilityLevel: .expert),
        title: "Test Session",
        description: "Test",
        resort: "Whistler",
        location: "BC",
        date: Date(),
        conditions: "Powder",
        skiIQ: 85,
        distance: 42.5,
        verticalDescent: 8420,
        duration: 6 * 3600 + 15 * 60,
        maxSpeed: 78.3,
        avgSpeed: 32.1,
        totalTurns: 1247,
        route: []
    )
    
    return MetricsGrid(session: mockSession)
        .padding()
        .background(Color.token(Theme.shared.tokens.background.container.light, dark: Theme.shared.tokens.background.container.dark))
        .withTheme()
}
