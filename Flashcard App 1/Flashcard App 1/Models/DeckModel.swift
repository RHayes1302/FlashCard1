//
//  DeckModel.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/8/26.
//

import Foundation

struct Deck: Identifiable, Codable {
    var id = UUID()
    var name: String
    var cards: [Flashcard]
    var lastStudied: Date? // Stores the timestamp of the last session
}
