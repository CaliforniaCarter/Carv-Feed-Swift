//
//  Theme.swift
//  Carv-Feed
//
//  Centralized theme manager combining tokens, typography, and spacing
//

import SwiftUI

class Theme: ObservableObject {
    static let shared = Theme()
    
    let tokens = DesignTokens.shared
    let spacing = Spacing()
    
    private init() {}
}

// MARK: - Environment Key

struct ThemeKey: EnvironmentKey {
    static let defaultValue = Theme.shared
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

// MARK: - View Extension

extension View {
    func withTheme() -> some View {
        self.environment(\.theme, Theme.shared)
    }
}
