//
//  StudyView.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/6/26.
//

import SwiftUI

struct StudyView: View {
    @EnvironmentObject var store: DeckStore
    @Environment(\.dismiss) private var dismiss
    let deck: Deck
    
    // 1. Link to all settings from SettingsView
    @AppStorage("shuffleCards") private var shuffleCards = true
    @AppStorage("showBackFirst") private var showBackFirst = false
    @AppStorage("cardsPerSession") private var cardsPerSession = 10
    @AppStorage("showScore") private var showScore = true
    @AppStorage("Repeat") private var repeatWrong = false
    
    @State private var sessionCards: [Flashcard] = []
    @State private var index = 0
    @State private var score = 0 // Track session score
    @State private var isFlipped = false

    var body: some View {
        VStack(spacing: 20) {
            // 2. Conditional Scoreboard
            if showScore {
                Text("Score: \(score)")
                    .font(.headline)
                    .padding(.top)
            }
            
            if !sessionCards.isEmpty {
                // Progress indicator
                Text("Card \(index + 1) of \(sessionCards.count)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                // Card Display
                ZStack {
                    RoundedRectangle(cornerRadius: 20).fill(.thinMaterial)
                    Text(isFlipped ? sessionCards[index].back : sessionCards[index].front)
                        .font(.title).padding()
                        .multilineTextAlignment(.center)
                }
                .frame(height: 300)
                .onTapGesture { withAnimation { isFlipped.toggle() } }

                // Grading Buttons
                HStack(spacing: 40) {
                    Button { handleAnswer(correct: false) } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red).font(.system(size: 60))
                    }
                    Button { handleAnswer(correct: true) } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green).font(.system(size: 60))
                    }
                }
            }
        }
        .padding()
        .navigationTitle(deck.name)
        .onAppear {
            setupSession()
        }
    }

    // 3. Setup logic for Shuffle, Cards Per Session, and Back First
    private func setupSession() {
        var cards = deck.cards
        
        if shuffleCards {
            cards.shuffle()
        }
        
        // Only take the amount of cards chosen in settings
        sessionCards = Array(cards.prefix(cardsPerSession))
        
        // Start with the back showing if preferred
        if showBackFirst {
            isFlipped = true
        }
    }

    private func handleAnswer(correct: Bool) {
        if correct {
            score += 1
        } else if repeatWrong {
            // Adds the missed card to the end of the session
            sessionCards.append(sessionCards[index])
        }
        
        if index < sessionCards.count - 1 {
            index += 1
            // Reset flip state based on user preference for the next card
            isFlipped = showBackFirst
        } else {
            store.updateLastStudied(for: deck.id)
            dismiss()
        }
    }
}
