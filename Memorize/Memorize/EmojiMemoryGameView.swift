//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 22/9/2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
        
    var body: some View {
        NavigationStack {
            VStack {
                cards
                    .padding()
                    .animation(.default, value: viewModel.cards)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("New game", action: viewModel.newGame)
                        }
                        ToolbarItem(placement: .topBarLeading) {
                            Text("Score: **\(viewModel.score)**")
                        }
                    }
                Button("Shuffle") {
                    viewModel.shuffle()
                }
            }
            .navigationTitle(viewModel.themeName)
        }
    }
    
    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundStyle(viewModel.cardsColor)
    }
    
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
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
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    @Previewable @StateObject var viewModel = EmojiMemoryGame()
    EmojiMemoryGameView(viewModel: viewModel)
}
