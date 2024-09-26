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
    private let spacing: CGFloat = 4
        
    var body: some View {
        NavigationStack {
            VStack {
                cards
                    .applyForegroundStyle(viewModel.cardsColor)
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
            .padding()
            .navigationTitle(viewModel.themeName)
        }
    }
    
    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
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

#Preview {
    @Previewable @StateObject var viewModel = EmojiMemoryGame()
    EmojiMemoryGameView(viewModel: viewModel)
}
