//
//  TriviaModels.swift
//  MuseumApp
//
//  Created by Sarah Yoon on 5/22/25.
//

import Foundation

struct TriviaResponse: Codable {
    // array of quiz questions retrieved from the API
    let results: [TriviaQuestion]
}

// structure for a trivia question
struct TriviaQuestion: Codable, Identifiable {
    let id = UUID()
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}
