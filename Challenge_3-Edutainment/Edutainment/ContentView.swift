//
//  ContentView.swift
//  Edutainment
//
//  Created by Georgi Ignatov on 20.05.25.
//

import SwiftUI

struct ContentView: View {
        
    // MARK: Properties
    
    private var range: ClosedRange<Int> = 2...12
    private var numberOfQuestionOptions = [5, 10, 20]
    
    // MARK: State
    
    // Multiplier
    @State private var isMultiplierSelected = false
    @State private var multiplier = 0
    // Number of questions
    @State private var isNumberOfQuestionsSelected = false
    @State private var numberOfQuestions = 0
    // Questions
    @State private var questions: [Question] = []
    @State private var currentQuestion = 1
    // Score
    @State private var score = 0
        
    // MARK: Body
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan, .purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            if !isMultiplierSelected {
                MultiplierSelectionView(range: range) { number in
                    multiplier = number
                    withAnimation {
                        isMultiplierSelected = true
                    }
                }
            } else if !isNumberOfQuestionsSelected {
                NumberOfQuestionsSelectionView(numberOfQuestionOptions: numberOfQuestionOptions) { number in
                    numberOfQuestions = number
                    generateQuestions()
                    withAnimation {
                        isNumberOfQuestionsSelected = true
                    }
                }
            } else if currentQuestion <= questions.count {
                let question = questions[currentQuestion - 1]
                QuestionView(questionNumber: currentQuestion, question: question) { isCorrect in
                    if isCorrect {
                        score += 1
                    }
                    
                    withAnimation {
                        currentQuestion += 1
                    }
                }
            } else {
                GameOverView(correctAnswers: score, totalQuestions: numberOfQuestions) {
                    restartGame()
                }
            }
        }
    }
}

// MARK: - Helpers

private extension ContentView {
    func generateQuestions() {
        (0..<numberOfQuestions).forEach { _ in
            // Get random multiplier
            let randomMultiplier = Int.random(in: range)
            
            // Prepare answers
            let correctAnswer = randomMultiplier * multiplier
            
            var shouldGoHigher = Bool.random()
            let closeMultiplier = shouldGoHigher ? randomMultiplier + 1 : randomMultiplier - 1
            let secondAnswer = closeMultiplier * multiplier
            
            let closeNumber = Int.random(in: 1...5)
            shouldGoHigher = Bool.random()
            var thirdAnswer = shouldGoHigher ? correctAnswer + closeNumber : correctAnswer - closeNumber
            
            // Make sure answers are unique
            if secondAnswer == thirdAnswer {
                thirdAnswer += 1
            }
            
            // Prepare question
            let answers = [correctAnswer, secondAnswer, thirdAnswer].shuffled()
            let correctAnswerIndex = answers.firstIndex(of: correctAnswer)!
            
            let question = Question(text: "What is \(multiplier) x \(randomMultiplier)?",
                                    answers: answers,
                                    correctAnswerIndex: correctAnswerIndex)
            
            // Add question to the array
            questions.append(question)
        }
    }
    
    func restartGame() {
        withAnimation {
            isMultiplierSelected = false
            multiplier = 0
            isNumberOfQuestionsSelected = false
            numberOfQuestions = 0
            questions.removeAll()
            currentQuestion = 1
            score = 0
        }
    }
}

#Preview {
    ContentView()
}
