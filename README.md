# Carv-Feed

A modern, mobile-first SwiftUI social feed for ski sessions, inspired by Strava and built with the Carv design system.

## Overview

Carv-Feed is a token-driven iOS application that displays a vertically scrollable feed of ski sessions. Each session card showcases:

- **User Information**: Avatar, name, and timestamp
- **Session Details**: Resort, location, date, and conditions
- **Performance Metrics**: Ski:IQ score, distance, vertical, time, speed, and turns
- **Route Visualization**: Abstract GPS route rendering
- **Social Features**: Likes, comments, and photo sharing
- **Editable Content**: Session titles and descriptions

## Architecture

### Token-Driven Design System

The app uses a flexible, token-based design system sourced from two JSON files:

- **`Tokens.json`**: Semantic design tokens (Background, Text, Data, Components, etc.) with light/dark mode support
- **`Primitives.json`**: Base colors, spacing values, and border radius primitives

All visual styling is derived from these tokens, ensuring:
- Consistent theming across the app
- Easy maintenance and updates
- Automatic light/dark mode support
- No hard-coded visual values

### Project Structure

```
Carv-Feed/
├── DesignSystem/
│   ├── DesignTokens.swift      # Token parser and color resolver
│   ├── Typography.swift         # Text styles and modifiers
│   ├── Spacing.swift           # Layout spacing constants
│   └── Theme.swift             # Centralized theme manager
├── Models/
│   ├── SkiSession.swift        # Session data model
│   ├── User.swift              # User profile model
│   └── Comment.swift           # Comment model
├── Services/
│   └── MockDataService.swift  # Mock data generator
├── Views/
│   ├── Components/
│   │   ├── SessionCard.swift   # Main feed card
│   │   ├── RouteMapView.swift  # Route visualization
│   │   ├── SkiIQBadge.swift    # Ski:IQ score badge
│   │   ├── MetricsGrid.swift   # Performance metrics
│   │   └── CommentSheet.swift  # Comments bottom sheet
│   ├── FeedView.swift          # Main feed screen
│   └── ContentView.swift       # Root view
├── Resources/
│   ├── Tokens.json
│   └── Primitives.json
└── CarvFeedApp.swift           # App entry point
```

## Features

### Current Implementation (Mock Data)

- ✅ Vertically scrollable feed with varied ski sessions
- ✅ Token-driven UI components
- ✅ Light and dark mode support
- ✅ Abstract route visualization (no external map SDK)
- ✅ Performance metrics display
- ✅ Ski:IQ badge with dynamic styling
- ✅ Like/comment interactions (local state)
- ✅ Mock comments with bottom sheet
- ✅ Responsive layout for all iPhone sizes

### Future Extensions

The architecture is designed to easily integrate real data:

- **API Integration**: Replace `MockDataService` with a real API client
- **Authentication**: Add user login and profile management
- **Real GPS Data**: Integrate MapKit or similar for actual route rendering
- **Photo Upload**: Connect to image storage service
- **Social Features**: Implement real-time likes, comments, and notifications
- **Analytics**: Track user engagement and session statistics

## Requirements

- **iOS**: 16.0+
- **Xcode**: 15.0+
- **Swift**: 5.9+

## Building the Project

1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/Carv-Feed.git
   cd Carv-Feed
   ```

2. Open the project in Xcode:
   ```bash
   open Carv-Feed.xcodeproj
   ```

3. Select a simulator or device (iPhone 15 Pro recommended)

4. Build and run: `⌘R`

## Design System Usage

### Accessing Tokens

```swift
// Get the shared theme
let theme = Theme.shared

// Use semantic colors
Text("Hello")
    .foregroundColor(theme.tokens.text.header)
    .background(theme.tokens.background.container)

// Use spacing
VStack(spacing: theme.spacing.md) {
    // Content
}
```

### Typography

```swift
Text("Session Title")
    .carvTypography(.header)

Text("Description text")
    .carvTypography(.body)
```

### Custom Components

All components are built using tokens:

```swift
SkiIQBadge(score: 85)  // Automatically styled based on score
RouteMapView(coordinates: session.route)  // Token-based colors
MetricsGrid(metrics: session.metrics)  // Consistent spacing and colors
```

## Mock Data

The app includes a rich set of mock data with:

- 8-10 varied ski sessions
- Different mountains (Whistler, Vail, Chamonix, Jackson Hole, etc.)
- Varied conditions (powder, groomed, moguls, backcountry)
- Performance levels ranging from beginner to expert
- Ski:IQ scores from 40-95
- Different route complexities
- Optional session photos

## Testing

### Light/Dark Mode

Toggle appearance in iOS Settings or Simulator:
- Settings → Developer → Dark Appearance

### Different Devices

Test on various screen sizes:
- iPhone SE (compact)
- iPhone 15 Pro (standard)
- iPhone 15 Pro Max (large)
- iPad (if supporting in future)

## Contributing

This is a demonstration project showcasing token-driven SwiftUI architecture. Feel free to use it as a reference for your own projects.

## License

MIT License - See LICENSE file for details

## Acknowledgments

- Design system tokens provided by Carv
- Inspired by Strava's activity feed UX
- Built with SwiftUI and modern iOS patterns
