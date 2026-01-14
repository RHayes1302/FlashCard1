//
//  AddDeckView.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/8/26.
//

import SwiftUI

struct AddDeckView: View {
   
    @EnvironmentObject var store: DeckStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Deck Details")) {
                    TextField("Enter deck name (e.g. Spanish 101)", text: $name)
                }
            }
            .navigationTitle("New Deck")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Cancel Button
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                // Add Button
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                        if !trimmedName.isEmpty {
                            
                            store.addDeck(name: trimmedName)
                            dismiss()
                        }
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .fontWeight(.bold)
                }
            }
        }
    }
}
