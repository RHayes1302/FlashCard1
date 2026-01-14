//
//  DeckListView.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/6/26.
//

import SwiftUI

struct DeckListView: View {
    @EnvironmentObject var store: DeckStore
    @State private var showingAddDeck = false
    @State private var showingSettings = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.decks) { deck in
                    NavigationLink(destination: DeckDetailView(deckID: deck.id)) {
                        VStack(alignment: .leading) {
                            Text(deck.name).font(.headline)
                            Text("\(deck.cards.count) cards").font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: store.deleteDeck)
            }
            .navigationTitle("Flashcards")
            
           
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
                
         
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddDeck = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
          
            
            .sheet(isPresented: $showingSettings) {
                NavigationStack {
                    SettingsView()
                }
            }
            .sheet(isPresented: $showingAddDeck) {
                AddDeckView()
            }
        }
    }
}
