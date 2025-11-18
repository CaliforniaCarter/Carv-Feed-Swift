//
//  DesignTokens.swift
//  Carv-Feed
//
//  Token parser for Carv design system
//  Loads and resolves colors from Tokens.json and Primitives.json
//

import SwiftUI

// MARK: - Token Models

struct TokenCollection: Codable {
    let id: String
    let name: String
    let modes: [String: String]
    let variables: [TokenVariable]
}

struct TokenVariable: Codable {
    let id: String
    let name: String
    let type: String
    let valuesByMode: [String: TokenValue]
    let resolvedValuesByMode: [String: ResolvedValue]
}

enum TokenValue: Codable {
    case color(ColorValue)
    case float(Double)
    case alias(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let colorValue = try? container.decode(ColorValue.self) {
            self = .color(colorValue)
        } else if let floatValue = try? container.decode(Double.self) {
            self = .float(floatValue)
        } else if let dict = try? container.decode([String: String].self),
                  let aliasId = dict["id"] {
            self = .alias(aliasId)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode TokenValue")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .color(let value):
            try container.encode(value)
        case .float(let value):
            try container.encode(value)
        case .alias(let id):
            try container.encode(["type": "VARIABLE_ALIAS", "id": id])
        }
    }
}

struct ColorValue: Codable {
    let r: Double
    let g: Double
    let b: Double
    let a: Double
}

struct ResolvedValue: Codable {
    let resolvedValue: ResolvedValueData
    let alias: String?
    let aliasName: String?
}

enum ResolvedValueData: Codable {
    case color(ColorValue)
    case float(Double)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let colorValue = try? container.decode(ColorValue.self) {
            self = .color(colorValue)
        } else if let floatValue = try? container.decode(Double.self) {
            self = .float(floatValue)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode ResolvedValueData")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .color(let value):
            try container.encode(value)
        case .float(let value):
            try container.encode(value)
        }
    }
}

// MARK: - Design Tokens

class DesignTokens {
    static let shared = DesignTokens()
    
    private var tokenCollection: TokenCollection?
    private var primitiveCollection: TokenCollection?
    private var colorCache: [String: (light: Color, dark: Color)] = [:]
    private var spacingCache: [String: CGFloat] = [:]
    
    private init() {
        loadTokens()
    }
    
    private func loadTokens() {
        // Load Tokens.json
        if let tokensURL = Bundle.main.url(forResource: "Tokens", withExtension: "json"),
           let tokensData = try? Data(contentsOf: tokensURL) {
            tokenCollection = try? JSONDecoder().decode(TokenCollection.self, from: tokensData)
        }
        
        // Load Primitives.json
        if let primitivesURL = Bundle.main.url(forResource: "Primitives", withExtension: "json"),
           let primitivesData = try? Data(contentsOf: primitivesURL) {
            primitiveCollection = try? JSONDecoder().decode(TokenCollection.self, from: primitivesData)
        }
    }
    
    // MARK: - Color Resolution
    
    func color(named name: String) -> (light: Color, dark: Color) {
        if let cached = colorCache[name] {
            return cached
        }
        
        guard let variable = tokenCollection?.variables.first(where: { $0.name == name }) else {
            print("⚠️ Token not found: \(name)")
            return (.gray, .gray)
        }
        
        let lightColor = resolveColor(from: variable, mode: "293:0") // Light mode
        let darkColor = resolveColor(from: variable, mode: "671:1")  // Dark mode
        
        let result = (light: lightColor, dark: darkColor)
        colorCache[name] = result
        return result
    }
    
    private func resolveColor(from variable: TokenVariable, mode: String) -> Color {
        guard let resolved = variable.resolvedValuesByMode[mode] else {
            return .gray
        }
        
        if case .color(let colorValue) = resolved.resolvedValue {
            return Color(
                red: colorValue.r,
                green: colorValue.g,
                blue: colorValue.b,
                opacity: colorValue.a
            )
        }
        
        return .gray
    }
    
    // MARK: - Primitive Colors
    
    func primitiveColor(named name: String) -> Color {
        guard let variable = primitiveCollection?.variables.first(where: { $0.name == name }),
              let resolved = variable.resolvedValuesByMode["2:0"] else {
            print("⚠️ Primitive color not found: \(name)")
            return .gray
        }
        
        if case .color(let colorValue) = resolved.resolvedValue {
            return Color(
                red: colorValue.r,
                green: colorValue.g,
                blue: colorValue.b,
                opacity: colorValue.a
            )
        }
        
        return .gray
    }
    
    // MARK: - Spacing
    
    func spacing(named name: String) -> CGFloat {
        if let cached = spacingCache[name] {
            return cached
        }
        
        guard let variable = primitiveCollection?.variables.first(where: { $0.name == name }),
              let resolved = variable.resolvedValuesByMode["2:0"] else {
            print("⚠️ Spacing not found: \(name)")
            return 0
        }
        
        if case .float(let value) = resolved.resolvedValue {
            spacingCache[name] = CGFloat(value)
            return CGFloat(value)
        }
        
        return 0
    }
    
    // MARK: - Semantic Token Groups
    
    var background: BackgroundTokens { BackgroundTokens() }
    var text: TextTokens { TextTokens() }
    var icon: IconTokens { IconTokens() }
    var data: DataTokens { DataTokens() }
    var components: ComponentTokens { ComponentTokens() }
}

// MARK: - Semantic Token Groups

struct BackgroundTokens {
    private let tokens = DesignTokens.shared
    
    var body: (light: Color, dark: Color) { tokens.color(named: "Background/Body") }
    var container: (light: Color, dark: Color) { tokens.color(named: "Background/Container") }
    var subContainer: (light: Color, dark: Color) { tokens.color(named: "Background/Sub Container") }
    var emptyProfile: (light: Color, dark: Color) { tokens.color(named: "Background/Empty Profile") }
}

struct TextTokens {
    private let tokens = DesignTokens.shared
    
    var header: (light: Color, dark: Color) { tokens.color(named: "Text/Header") }
    var body: (light: Color, dark: Color) { tokens.color(named: "Text/Body") }
    var label: (light: Color, dark: Color) { tokens.color(named: "Text/Label") }
    var subHeader: (light: Color, dark: Color) { tokens.color(named: "Text/Sub Header") }
    var containerHeader: (light: Color, dark: Color) { tokens.color(named: "Text/Container Header") }
    var button: (light: Color, dark: Color) { tokens.color(named: "Text/Button") }
    var title: (light: Color, dark: Color) { tokens.color(named: "Text/Title") }
    var highlight: (light: Color, dark: Color) { tokens.color(named: "Text/Highlight") }
}

struct IconTokens {
    private let tokens = DesignTokens.shared
    
    var ui: (light: Color, dark: Color) { tokens.color(named: "Icon/UI") }
    var muted: (light: Color, dark: Color) { tokens.color(named: "Icon/Muted") }
    var special: (light: Color, dark: Color) { tokens.color(named: "Icon/Special") }
    var star: (light: Color, dark: Color) { tokens.color(named: "Icon/Star") }
}

struct DataTokens {
    private let tokens = DesignTokens.shared
    
    var main: (light: Color, dark: Color) { tokens.color(named: "Data/Main") }
    var gps: (light: Color, dark: Color) { tokens.color(named: "Data/GPS") }
    var targetZone: (light: Color, dark: Color) { tokens.color(named: "Data/Target Zone") }
}

struct ComponentTokens {
    private let tokens = DesignTokens.shared
    
    var buttonPrimary: (light: Color, dark: Color) { tokens.color(named: "Components/Button/Primary") }
    var buttonSpecial: (light: Color, dark: Color) { tokens.color(named: "Components/Button/Special") }
    var buttonDisabled: (light: Color, dark: Color) { tokens.color(named: "Components/Button/Disabled") }
    var divider: (light: Color, dark: Color) { tokens.color(named: "Components/Divider") }
    var dividerInContainer: (light: Color, dark: Color) { tokens.color(named: "Components/Divider (in container)") }
}

// MARK: - SwiftUI Extensions

extension Color {
    /// Creates a color that adapts to light/dark mode from design tokens
    static func token(_ lightColor: Color, dark darkColor: Color) -> Color {
        Color(UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ?
                UIColor(darkColor) : UIColor(lightColor)
        })
    }
}
