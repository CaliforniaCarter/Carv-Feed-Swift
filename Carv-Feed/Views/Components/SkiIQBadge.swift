//
//  SkiIQBadge.swift
//  Carv-Feed
//
//  Ski:IQ score badge with token-driven styling
//

import SwiftUI

struct SkiIQBadge: View {
    let score: Int
    let type: SkiIQBadgeType
    @Environment(\.theme) private var theme
    
    init(score: Int) {
        self.score = score
        // Determine badge type based on score
        switch score {
        case 90...100:
            self.type = .mountainGoat
        case 80..<90:
            self.type = .grimRipper
        case 1..<80:
            self.type = .default
        default:
            self.type = .empty
        }
    }
    
    var body: some View {
        HStack(spacing: theme.spacing.sm) {
            // Ski:IQ label and score
            VStack(alignment: .leading, spacing: 2) {
                Text("SKI:IQ")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(primaryTextColor)
                
                Text("\(score)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(primaryTextColor)
            }
            
            // Badge icon/decoration
            if type == .mountainGoat {
                Image(systemName: "mountain.2.fill")
                    .font(.system(size: 20))
                    .foregroundColor(primaryTextColor)
            } else if type == .grimRipper {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 20))
                    .foregroundColor(primaryTextColor)
            }
        }
        .padding(.horizontal, theme.spacing.lg)
        .padding(.vertical, theme.spacing.md)
        .background(
            RoundedRectangle(cornerRadius: theme.spacing.radiusSmall)
                .fill(backgroundGradient)
        )
    }
    
    // MARK: - Styling
    
    private var backgroundGradient: LinearGradient {
        switch type {
        case .mountainGoat:
            // Gold gradient for top performers
            return LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.84, blue: 0.0),
                    Color(red: 0.85, green: 0.65, blue: 0.13)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .grimRipper:
            // Dark gradient for high performers
            return LinearGradient(
                colors: [
                    .token(theme.tokens.primitiveColor(named: "Colour/Grey/09"), dark: theme.tokens.primitiveColor(named: "Colour/Grey/08")),
                    .token(theme.tokens.primitiveColor(named: "Colour/Grey/10"), dark: theme.tokens.primitiveColor(named: "Colour/Grey/09"))
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .default:
            // Teal gradient for standard
            return LinearGradient(
                colors: [
                    .token(theme.tokens.data.main.light, dark: theme.tokens.data.main.dark),
                    .token(theme.tokens.data.gps.light, dark: theme.tokens.data.gps.dark)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .empty:
            // Gray for empty/low scores
            return LinearGradient(
                colors: [
                    .token(theme.tokens.background.emptyProfile.light, dark: theme.tokens.background.emptyProfile.dark),
                    .token(theme.tokens.background.emptyProfile.light, dark: theme.tokens.background.emptyProfile.dark)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    private var primaryTextColor: Color {
        switch type {
        case .mountainGoat:
            return .token(theme.tokens.primitiveColor(named: "Colour/Black/01"), dark: theme.tokens.primitiveColor(named: "Colour/Black/01"))
        case .grimRipper:
            return .token(theme.tokens.primitiveColor(named: "Colour/White"), dark: theme.tokens.primitiveColor(named: "Colour/White"))
        case .default:
            return .token(theme.tokens.primitiveColor(named: "Colour/Grey/10"), dark: theme.tokens.primitiveColor(named: "Colour/Grey/10"))
        case .empty:
            return .token(theme.tokens.text.body.light, dark: theme.tokens.text.body.dark)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        SkiIQBadge(score: 95)  // Mountain GOAT
        SkiIQBadge(score: 85)  // Grim Ripper
        SkiIQBadge(score: 72)  // Default
        SkiIQBadge(score: 45)  // Empty/Low
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .withTheme()
}
