//
//  CommentSheet.swift
//  Carv-Feed
//
//  Bottom sheet for viewing and adding comments
//

import SwiftUI

struct CommentSheet: View {
    @Binding var isPresented: Bool
    let comments: [Comment]
    @State private var newCommentText = ""
    @Environment(\.theme) private var theme
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Comments list
                if comments.isEmpty {
                    emptyState
                } else {
                    ScrollView {
                        LazyVStack(spacing: theme.spacing.lg) {
                            ForEach(comments) { comment in
                                CommentRow(comment: comment)
                            }
                        }
                        .padding()
                    }
                }
                
                Divider()
                
                // Add comment input
                HStack(spacing: theme.spacing.md) {
                    TextField("Add a comment...", text: $newCommentText)
                        .textFieldStyle(.plain)
                        .padding(theme.spacing.md)
                        .background(
                            RoundedRectangle(cornerRadius: theme.spacing.radiusXSmall)
                                .fill(Color.token(theme.tokens.background.subContainer.light, dark: theme.tokens.background.subContainer.dark))
                        )
                    
                    Button(action: addComment) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.token(theme.tokens.components.buttonPrimary.light, dark: theme.tokens.components.buttonPrimary.dark))
                    }
                    .disabled(newCommentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding()
                .background(Color.token(theme.tokens.background.container.light, dark: theme.tokens.background.container.dark))
            }
            .navigationTitle("Comments")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: theme.spacing.lg) {
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 48))
                .foregroundColor(.token(theme.tokens.icon.muted.light, dark: theme.tokens.icon.muted.dark))
            
            Text("No comments yet")
                .carvTypography(.header, color: theme.tokens.text.header)
            
            Text("Be the first to comment!")
                .carvTypography(.body, color: theme.tokens.text.label)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func addComment() {
        // TODO: Add comment to session (local state for now)
        print("Adding comment: \(newCommentText)")
        newCommentText = ""
    }
}

struct CommentRow: View {
    let comment: Comment
    @Environment(\.theme) private var theme
    
    var body: some View {
        HStack(alignment: .top, spacing: theme.spacing.md) {
            // Avatar
            Circle()
                .fill(Color.token(theme.tokens.background.emptyProfile.light, dark: theme.tokens.background.emptyProfile.dark))
                .frame(width: 40, height: 40)
                .overlay(
                    Text(comment.user.name.prefix(1))
                        .carvTypography(.header, color: theme.tokens.text.header)
                )
            
            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                HStack {
                    Text(comment.user.name)
                        .carvTypography(.subHeader, color: theme.tokens.text.header)
                    
                    Spacer()
                    
                    Text(comment.timestamp, style: .relative)
                        .carvTypography(.caption, color: theme.tokens.text.label)
                }
                
                Text(comment.text)
                    .carvTypography(.body, color: theme.tokens.text.body)
            }
        }
    }
}

#Preview {
    CommentSheet(
        isPresented: .constant(true),
        comments: [
            Comment(
                user: User(name: "Sarah Chen", abilityLevel: .expert),
                text: "Awesome run! 🎿",
                timestamp: Date().addingTimeInterval(-3600)
            ),
            Comment(
                user: User(name: "Marcus Johnson", abilityLevel: .advanced),
                text: "Looks amazing! Wish I was there.",
                timestamp: Date().addingTimeInterval(-7200)
            )
        ]
    )
    .withTheme()
}
