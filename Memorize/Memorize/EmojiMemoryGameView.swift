//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 22/9/2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    private static let themes: [Theme] = [.animals, .food, .nature]
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State private var currentTheme: Theme = .animals
    @State private var emojis: [String] = Theme.animals.shuffled
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            Button("Shuffle") {
                viewModel.shuffle()
            }
//            themePicker
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundStyle(currentTheme.foregroundColor)
    }
    
    var themePicker: some View {
        HStack(alignment: .lastTextBaseline) {
            ForEach(Self.themes.indices, id: \.self) { index in
                let theme = Self.themes[index]
                Button {
                    currentTheme = theme
                    emojis = theme.shuffled
                } label: {
                    VStack {
                        theme.icon
                            .imageScale(.large)
                            .font(.title2)
                        Text(theme.name)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
