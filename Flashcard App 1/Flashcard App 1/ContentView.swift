//
//  ContentView.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/6/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: DeckStore
    @State private var showingAddDeck = false // Controls the pop-up
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.decks) { deck in
                    NavigationLink(destination: DeckDetailView(deckID: deck.id)) {
                        Text(deck.name)
                    }
                }
                .onDelete(perform: store.deleteDeck)
            }
            .navigationTitle("Flashcards")
            .toolbar {
                // This puts the button in the top right
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddDeck = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            // This is the "doorway" that opens the AddDeckView
            .sheet(isPresented: $showingAddDeck) {
                AddDeckView()
            }
        }
    }
}
