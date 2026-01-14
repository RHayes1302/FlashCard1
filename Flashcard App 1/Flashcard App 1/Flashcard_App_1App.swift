//
//  Flashcard_App_1App.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/6/26.
//

import SwiftUI

@main
struct Flashcard_App_1App: App {
    
    @StateObject private var store = DeckStore()
    @AppStorage("DarkMode") var isDarkMode: Bool = false
    @AppStorage("showScore") private var showScore: Bool = true
    @AppStorage("Repeat") private var showSpacedRepetition: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                DeckListView()
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            
            .environmentObject(store)
        }
    }
}
