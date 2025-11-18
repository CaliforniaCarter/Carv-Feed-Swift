//
//  Typography.swift
//  Carv-Feed
//
//  Typography system and text styles
//

import SwiftUI

enum CarvTextStyle {
    case largeTitle
    case title
    case title2
    case title3
    case header
    case subHeader
    case body
    case bodyBold
    case label
    case caption
    case caption2
    
    var font: Font {
        switch self {
        case .largeTitle:
            return .system(size: 34, weight: .bold)
        case .title:
            return .system(size: 28, weight: .bold)
        case .title2:
            return .system(size: 22, weight: .bold)
        case .title3:
            return .system(size: 20, weight: .semibold)
        case .header:
            return .system(size: 17, weight: .semibold)
        case .subHeader:
            return .system(size: 15, weight: .medium)
        case .body:
            return .system(size: 17, weight: .regular)
        case .bodyBold:
            return .system(size: 17, weight: .semibold)
        case .label:
            return .system(size: 15, weight: .regular)
        case .caption:
            return .system(size: 13, weight: .regular)
        case .caption2:
            return .system(size: 11, weight: .regular)
        }
    }
    
    var lineSpacing: CGFloat {
        switch self {
        case .largeTitle, .title, .title2:
            return 2
        case .title3, .header:
            return 1.5
        default:
            return 1
        }
    }
}

// MARK: - View Modifiers

struct CarvTypographyModifier: ViewModifier {
    let style: CarvTextStyle
    let color: (light: Color, dark: Color)?
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
            .lineSpacing(style.lineSpacing)
            .apply { view in
                if let color = color {
                    view.foregroundColor(.token(color.light, dark: color.dark))
                } else {
                    view
                }
            }
    }
}

extension View {
    func carvTypography(_ style: CarvTextStyle, color: (light: Color, dark: Color)? = nil) -> some View {
        modifier(CarvTypographyModifier(style: style, color: color))
    }
    
    // Helper for conditional modifiers
    @ViewBuilder
    func apply<V: View>(@ViewBuilder _ transform: (Self) -> V) -> some View {
        transform(self)
    }
}
