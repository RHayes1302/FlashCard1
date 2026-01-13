//
//  DeckDetailView.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/8/26.
//

import SwiftUI

struct DeckDetailView: View {
    @EnvironmentObject var store: DeckStore
    let deckID: UUID
    
    @State private var showingAddCard = false

    var body: some View {
        if let deck = store.deck(for: deckID) {
            VStack {
                if deck.cards.isEmpty {
                    ContentUnavailableView("No Cards", systemImage: "square.stack.3d.up")
                } else {
                    List {
                        ForEach(deck.cards) { card in
                            VStack(alignment: .leading) {
                                Text(card.front).font(.headline)
                                Text(card.back).font(.subheadline).foregroundStyle(.secondary)
                            }
                        }
                        // --- FIX: store (no $) and matching labels (in/at) ---
                        .onDelete { offsets in
                            store.deleteCard(in: deckID, at: offsets)
                        }
                    }
                }
                
                NavigationLink(destination: StudyView(deck: deck)) {
                    Label("Study This Deck", systemImage: "play.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .disabled(deck.cards.isEmpty)
            }
            .navigationTitle(deck.name)
            .toolbar {
                Button { showingAddCard = true } label: { Image(systemName: "plus") }
            }
            .sheet(isPresented: $showingAddCard) {
                AddCardView(deckID: deck.id)
            }
        } else {
            Text("Deck not found")
        }
    }
}
