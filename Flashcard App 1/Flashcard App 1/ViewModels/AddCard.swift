//
//  AddCard.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/12/26.
//
import SwiftUI

struct AddCardView: View {
    @EnvironmentObject var store: DeckStore
    @Environment(\.dismiss) private var dismiss
    let deckID: UUID
    
    @State private var front = ""
    @State private var back = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Front of Card") {
                    TextField("Question", text: $front)
                }
                Section("Back of Card") {
                    TextField("Answer", text: $back)
                }
            }
            .navigationTitle("New Card")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        store.addCard(to: deckID, front: front, back: back)
                        dismiss()
                    }
                    .disabled(front.isEmpty || back.isEmpty)
                }
            }
        }
    }
}
