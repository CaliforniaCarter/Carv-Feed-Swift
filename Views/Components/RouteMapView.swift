//
//  RouteMapView.swift
//  Carv-Feed
//
//  Abstract route visualization using SwiftUI paths
//  No external map SDK required
//

import SwiftUI

struct RouteMapView: View {
    let route: [RoutePoint]
    @Environment(\.theme) private var theme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient (mountain/sky effect)
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.1),
                        Color.white.opacity(0.3)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                // Route path
                if !route.isEmpty {
                    RoutePath(points: route)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    .token(theme.tokens.data.gps.light, dark: theme.tokens.data.gps.dark),
                                    .token(theme.tokens.data.main.light, dark: theme.tokens.data.main.dark)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
                        )
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                    
                    // Start point marker
                    if let firstPoint = normalizedPoints(in: geometry.size).first {
                        Circle()
                            .fill(.token(theme.tokens.data.main.light, dark: theme.tokens.data.main.dark))
                            .frame(width: 10, height: 10)
                            .position(firstPoint)
                            .shadow(color: .black.opacity(0.3), radius: 2)
                    }
                    
                    // End point marker
                    if let lastPoint = normalizedPoints(in: geometry.size).last {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .position(lastPoint)
                            .shadow(color: .black.opacity(0.3), radius: 2)
                    }
                }
            }
        }
        .frame(height: 180)
        .clipShape(RoundedRectangle(cornerRadius: theme.spacing.radiusSmall))
    }
    
    // MARK: - Helpers
    
    private func normalizedPoints(in size: CGSize) -> [CGPoint] {
        guard !route.isEmpty else { return [] }
        
        // Find bounds
        let latitudes = route.map { $0.latitude }
        let longitudes = route.map { $0.longitude }
        
        guard let minLat = latitudes.min(),
              let maxLat = latitudes.max(),
              let minLon = longitudes.min(),
              let maxLon = longitudes.max() else {
            return []
        }
        
        let latRange = maxLat - minLat
        let lonRange = maxLon - minLon
        
        // Add padding
        let padding: CGFloat = 20
        let availableWidth = size.width - (padding * 2)
        let availableHeight = size.height - (padding * 2)
        
        // Normalize points to fit in view
        return route.map { point in
            let normalizedX = latRange > 0 ? (point.latitude - minLat) / latRange : 0.5
            let normalizedY = lonRange > 0 ? (point.longitude - minLon) / lonRange : 0.5
            
            return CGPoint(
                x: padding + (CGFloat(normalizedX) * availableWidth),
                y: padding + (CGFloat(1 - normalizedY) * availableHeight) // Invert Y for screen coordinates
            )
        }
    }
}

// MARK: - Route Path Shape

struct RoutePath: Shape {
    let points: [RoutePoint]
    
    func path(in rect: CGRect) -> Path {
        guard !points.isEmpty else { return Path() }
        
        // Normalize points
        let normalizedPoints = normalizePoints(in: rect.size)
        
        var path = Path()
        
        if let firstPoint = normalizedPoints.first {
            path.move(to: firstPoint)
            
            // Create smooth curve through points
            for i in 1..<normalizedPoints.count {
                let point = normalizedPoints[i]
                
                if i == 1 {
                    path.addLine(to: point)
                } else {
                    // Use quadratic curves for smoother path
                    let previousPoint = normalizedPoints[i - 1]
                    let midPoint = CGPoint(
                        x: (previousPoint.x + point.x) / 2,
                        y: (previousPoint.y + point.y) / 2
                    )
                    path.addQuadCurve(to: midPoint, control: previousPoint)
                    path.addLine(to: point)
                }
            }
        }
        
        return path
    }
    
    private func normalizePoints(in size: CGSize) -> [CGPoint] {
        guard !points.isEmpty else { return [] }
        
        let latitudes = points.map { $0.latitude }
        let longitudes = points.map { $0.longitude }
        
        guard let minLat = latitudes.min(),
              let maxLat = latitudes.max(),
              let minLon = longitudes.min(),
              let maxLon = longitudes.max() else {
            return []
        }
        
        let latRange = max(maxLat - minLat, 0.0001)
        let lonRange = max(maxLon - minLon, 0.0001)
        
        let padding: CGFloat = 20
        let availableWidth = size.width - (padding * 2)
        let availableHeight = size.height - (padding * 2)
        
        return points.map { point in
            let normalizedX = (point.latitude - minLat) / latRange
            let normalizedY = (point.longitude - minLon) / lonRange
            
            return CGPoint(
                x: padding + (CGFloat(normalizedX) * availableWidth),
                y: padding + (CGFloat(1 - normalizedY) * availableHeight)
            )
        }
    }
}

#Preview {
    let mockRoute = (0..<50).map { i in
        RoutePoint(
            latitude: 50.0 + Double(i) * 0.0001 + Double.random(in: -0.00005...0.00005),
            longitude: -122.0 + Double(i) * 0.0002 + Double.random(in: -0.0001...0.0001),
            elevation: 2000 - Double(i) * 10
        )
    }
    
    return RouteMapView(route: mockRoute)
        .padding()
        .withTheme()
}
