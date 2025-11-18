//
//  ContentView.swift
//  Carv-Feed
//
//  Root view with theme setup
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FeedView()
            .withTheme()
    }
}

#Preview {
    ContentView()
}
