//
//  SettingView.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/6/26.
//

import SwiftUI

struct SettingsView:View {
    
    @AppStorage("shuffleCards") private var shuffleCards: Bool = true
    @AppStorage("showBackFirst") private var showBackFirst: Bool = false
    @AppStorage("cardsPerSession") private var cardsPerSession: Int = 10
    @AppStorage("DarkMode") private var darkmode: Bool = false
    @AppStorage("showScore") private var showScore: Bool = true
    @AppStorage("Repeat") private var showSpacedRepetition: Bool = false
    var body: some View {
        Form {
            Section("Study"){
                Toggle("Shuffle cards",isOn:$shuffleCards)
                Toggle("Show back first",isOn:$showBackFirst)
                Toggle("Dark Mode",isOn: $darkmode)
                Toggle("Show Score",isOn: $showScore)
                Toggle("Repeat",isOn: $showSpacedRepetition)
                
                Stepper("Cards per session: \(cardsPerSession)",
                        value: $cardsPerSession,
                        in:1...50)
                
            }
            
            Section("About"){
                Text("These settings persist using UserDefault view @AppStorage")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                
            }
        }
        .navigationTitle("Settings")
        
        
    }
}

