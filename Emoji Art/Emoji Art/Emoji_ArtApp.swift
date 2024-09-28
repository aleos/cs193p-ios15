//
//  Emoji_ArtApp.swift
//  Emoji Art
//
//  Created by Alexander Ostrovsky on 28/9/2024.
//

import SwiftUI

@main
struct Emoji_ArtApp: App {
    @StateObject var defaultDocument = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: defaultDocument)
        }
    }
}
