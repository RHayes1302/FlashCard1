//
//  FlashcardModel.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/6/26.
//

import Foundation


    struct Flashcard: Identifiable, Codable, Equatable{
        var id:UUID = UUID()
        var front: String
        var back: String
    }

