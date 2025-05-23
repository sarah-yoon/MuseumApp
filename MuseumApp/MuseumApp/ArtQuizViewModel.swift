//
//  ArtQuizViewModel.swift
//  MuseumApp
//
//  Created by Sarah Yoon on 5/22/25.
//

import Foundation

// entire class runs on the main thread
@MainActor
//
class ArtQuizViewModel: ObservableObject {
    // list of quiz questions stored from API
    @Published var questions: [TriviaQuestion] = []
    // the question the user is currently on
    @Published var currentQuestionIndex = 0
    //controls whether or not the results should be shown
    @Published var showResult = false
    // temporary storage for whether the answer was correct or not
    @Published var correctAnswer: Bool?

    // accesses the current quesstion
    var currentQuestion: TriviaQuestion? {
        questions.isEmpty ? nil : questions[currentQuestionIndex]
    }

    //function to get the quiz questions
    func fetchQuestions() async {
        // API url
        guard let url = URL(string: "https://opentdb.com/api.php?amount=5&category=25&difficulty=easy&type=multiple&encode=url3986") else { return }

        do {
            // gets the data
            let (data, _) = try await URLSession.shared.data(from: url)
            // decodes JSON into an array of questions
            let decoded = try JSONDecoder().decode(TriviaResponse.self, from: data)
            //shuffles questions
            self.questions = decoded.results.shuffled()
            //resets to the first question
            self.currentQuestionIndex = 0
        } catch {
            // prints an error if it fails
            print("Failed to load:", error)
        }
    }
    
    // function for when the user submits an answer
    func submitAnswer(_ answer: String) {
        // checks if there is a valid answer
        if let question = currentQuestion {
            // compares the user's answer and the actual answer and stores the result
            correctAnswer = (answer == question.correct_answer)
            // enables showing the results
            showResult = true
        }
    }

    //function for showing the next question
    func nextQuestion() {
        //turns off the results and resets the correct answer's value
        showResult = false
        correctAnswer = nil
        
        // checks if more questions remain
        if currentQuestionIndex + 1 < questions.count {
            // if they do, it moves on the next question
            currentQuestionIndex += 1
        } else {
            // if not, it goes back to the beginning
            currentQuestionIndex = 0
        }
    }
}
