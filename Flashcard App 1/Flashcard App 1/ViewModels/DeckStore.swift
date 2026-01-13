//
//  DeckStore.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/6/26.
//
import Foundation

final class DeckStore: ObservableObject {
    @Published var decks: [Deck] = [] {
        didSet { save() }
    }
    
    private let store = FileStore(fileName: "decks.json")
    
    init() { load() }

    func addDeck(name: String) {
        let newDeck = Deck(name: name, cards: [])
        decks.append(newDeck)
    }

    func deck(for deckID: UUID) -> Deck? {
        decks.first(where: { $0.id == deckID })
    }

    func addCard(to deckID: UUID, front: String, back: String) {
        if let index = decks.firstIndex(where: { $0.id == deckID }) {
            decks[index].cards.append(Flashcard(front: front, back: back))
        }
    }

    // --- ADDED THIS FUNCTION ---
    func deleteCard(in deckID: UUID, at offsets: IndexSet) {
        if let index = decks.firstIndex(where: { $0.id == deckID }) {
            decks[index].cards.remove(atOffsets: offsets)
        }
    }
    // ---------------------------

    func updateLastStudied(for deckID: UUID) {
        if let index = decks.firstIndex(where: { $0.id == deckID }) {
            decks[index].lastStudied = Date()
        }
    }

    func deleteDeck(at offsets: IndexSet) {
        decks.remove(atOffsets: offsets)
    }

    private func load() {
        do {
            decks = try store.load(type: [Deck].self)
        } catch {
            decks = []
        }
    }
    
    private func save() {
        try? store.save(decks)
    }
}
