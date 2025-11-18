//
//  Spacing.swift
//  Carv-Feed
//
//  Spacing constants from design primitives
//

import SwiftUI

struct Spacing {
    private let tokens = DesignTokens.shared
    
    // Spacing values from Primitives.json
    var xs2: CGFloat { tokens.spacing(named: "Spacing/02") }   // 2
    var xs: CGFloat { tokens.spacing(named: "Spacing/04") }    // 4
    var sm: CGFloat { tokens.spacing(named: "Spacing/08") }    // 8
    var md: CGFloat { tokens.spacing(named: "Spacing/12") }    // 12
    var lg: CGFloat { tokens.spacing(named: "Spacing/16") }    // 16
    var xl: CGFloat { tokens.spacing(named: "Spacing/20") }    // 20
    var xl2: CGFloat { tokens.spacing(named: "Spacing/24") }   // 24
    var xl3: CGFloat { tokens.spacing(named: "Spacing/28") }   // 28
    var xl4: CGFloat { tokens.spacing(named: "Spacing/32") }   // 32
    var xl5: CGFloat { tokens.spacing(named: "Spacing/40") }   // 40
    var xl6: CGFloat { tokens.spacing(named: "Spacing/48") }   // 48
    var xl7: CGFloat { tokens.spacing(named: "Spacing/56") }   // 56
    var xl8: CGFloat { tokens.spacing(named: "Spacing/64") }   // 64
    var xl9: CGFloat { tokens.spacing(named: "Spacing/72") }   // 72
    var xl10: CGFloat { tokens.spacing(named: "Spacing/80") }  // 80
    
    // Corner radius
    var radiusLarge: CGFloat { tokens.spacing(named: "Radius/40") }  // 40
    var radiusMedium: CGFloat { 20 }
    var radiusSmall: CGFloat { 12 }
    var radiusXSmall: CGFloat { 8 }
}
