#!/bin/bash

# Carv-Feed Xcode Project Setup Script
# This script creates an Xcode project for the Carv-Feed iOS app

echo "🎿 Setting up Carv-Feed Xcode Project..."

# Create the Xcode project using xcodebuild
# Note: You'll need to open Xcode and create a new iOS App project manually
# Then move the source files into the project

echo ""
echo "📱 To complete the setup:"
echo ""
echo "1. Open Xcode"
echo "2. Create a new iOS App project:"
echo "   - Product Name: Carv-Feed"
echo "   - Team: Your team"
echo "   - Organization Identifier: com.carv (or your identifier)"
echo "   - Interface: SwiftUI"
echo "   - Language: Swift"
echo "   - Save in: $(pwd)"
echo ""
echo "3. Delete the default ContentView.swift and CarvFeedApp.swift that Xcode creates"
echo ""
echo "4. Add all files from the Carv-Feed directory to your project:"
echo "   - Right-click on Carv-Feed folder in Xcode"
echo "   - Select 'Add Files to Carv-Feed...'"
echo "   - Select all .swift files and folders"
echo "   - Make sure 'Copy items if needed' is UNCHECKED"
echo "   - Make sure 'Create groups' is selected"
echo "   - Click Add"
echo ""
echo "5. Add the JSON files to the project:"
echo "   - Drag Carv-Feed/Resources/Tokens.json into Xcode"
echo "   - Drag Carv-Feed/Resources/Primitives.json into Xcode"
echo "   - Make sure they're added to the app target"
echo ""
echo "6. Build and run! (⌘R)"
echo ""
echo "✅ All source files are ready in the Carv-Feed directory"
echo ""
