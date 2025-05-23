//
//  ArtQuizView.swift
//  MuseumApp
//
//  Created by Sarah Yoon on 5/22/25.
//

import SwiftUI

// view for the art trivia section
struct ArtQuizView: View {
    // handles the quiz logic and data
    @StateObject var viewModel = ArtQuizViewModel()
    
    var body: some View {
        // adds space in between the elements
        VStack(spacing: 24) {
            
            // if a question exists, display it
            if let question = viewModel.currentQuestion {
                
                // displays the questions after decoding it
                Text(decode(question.question))
                    .font(.title3)
                    .padding()
                
                // shuffle and shows all the answer choices
                let answers = ([question.correct_answer] + question.incorrect_answers).shuffled()
                ForEach(answers, id: \.self) { answer in
                    Button(decode(answer)) {
                        // handles the user's answer
                        viewModel.submitAnswer(answer)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple.opacity(0.2))
                    .foregroundColor(Color.purple)
                    .cornerRadius(10)
                }

                // results show only if an answer has been submitted
                if viewModel.showResult {
                    //display correct/wrong depending on what the use chose
                    Label(
                        viewModel.correctAnswer == true ? "Correct!" : "Wrong",
                        systemImage: viewModel.correctAnswer == true ? "checkmark.circle.fill" : "xmark.circle.fill"
                    )
                    .font(.headline)
                    .foregroundColor(viewModel.correctAnswer == true ? .green : .red)
                    
                    // if the answer was wrong, show the correct one
                    if viewModel.correctAnswer == false,
                       let correct = viewModel.currentQuestion?.correct_answer {
                        Text("Correct answer: \(decode(correct))")
                            .font(.subheadline)
                            .foregroundColor(.purple)
                    }

                    // button to naviagte to the next question
                    Button {
                        viewModel.nextQuestion()
                    } label: {
                        Text("Next")
                            .font(.title3)
                    }
                }
            } else {
                // if no questions are popping up, show a loading spinner
                ProgressView()
            }
            // dots on the bottom to show which question the user is on
            HStack(spacing: 8) {
                ForEach(0..<viewModel.questions.count, id: \.self) { index in
                    Image(systemName: index == viewModel.currentQuestionIndex ? "circle.fill" : "circle")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(index == viewModel.currentQuestionIndex ? .purple : .gray)
                }
            }
        }
        .padding()
        // navigation bar title
        .navigationTitle("Art Quiz")
        .task {
            // fetch the questions when the view appears
            await viewModel.fetchQuestions()
        }
    }

    // function that decodes url string
    func decode(_ text: String) -> String {
        //decode RFC3986 URL encoding
        return text.removingPercentEncoding ?? text
    }
}


#Preview {
    ArtQuizView()
}
