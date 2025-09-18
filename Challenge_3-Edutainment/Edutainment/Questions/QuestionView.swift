//
//  QuestionView.swift
//  Edutainment
//
//  Created by Georgi Ignatov on 20.05.25.
//

import SwiftUI

struct QuestionView: View {
    
    // MARK: Constants
    
    private enum Constant {
        static let buttonFontSize: CGFloat = 75
        static let questionShadowRadius: CGFloat = 8
        static let animationDuration: TimeInterval = 0.75
    }
    
    // MARK: Properties
    
    private let questionNumber: Int
    private let question: Question
    private let questionCompletionAction: (Bool) -> Void
    
    private var isQuestionAnsweredCorrectly: Bool {
        selectedAnswerIndex == question.correctAnswerIndex
    }
    
    // MARK: State
    
    @State private var selectedAnswerIndex: Int?
    
    // MARK: Init
    
    init(questionNumber: Int, question: Question, questionCompletionAction: @escaping (Bool) -> Void) {
        self.questionNumber = questionNumber
        self.question = question
        self.questionCompletionAction = questionCompletionAction
    }
    
    // MARK: - Body
    
    var body: some View {
        if selectedAnswerIndex != nil {
            AnsweredQuestionView(isCorrect: isQuestionAnsweredCorrectly) {
                questionCompletionAction(isQuestionAnsweredCorrectly)
                selectedAnswerIndex = nil
            }
        } else {
            VStack {
                Spacer()
                Text("Question \(questionNumber)")
                    .font(.largeTitle.bold())
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.indigo)
                
                Text(question.text)
                    .font(.largeTitle.weight(.heavy))
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.yellow).shadow(radius: Constant.questionShadowRadius)
                
                List {
                    ForEach(0..<question.answers.count, id: \.self) { index in
                        Button {
                            onButtonTap(at: index)
                        } label: {
                            Text("\(question.answers[index])")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .font(.system(size: Constant.buttonFontSize).weight(.black))
                        }
                        .buttonStyle(.primaryButton)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                }
                .scrollBounceBehavior(.basedOnSize)
                .scrollIndicatorsFlash(onAppear: true)
                .scrollContentBackground(.hidden)
            }
        }
    }
    
    // MARK: Events
    
    private func onButtonTap(at index: Int) {
        withAnimation {
            selectedAnswerIndex = index
        }
    }
}

#Preview {
    QuestionView(questionNumber: 1, question: Question(text: "What is 2 x 3?", answers: [6, 7, 400], correctAnswerIndex: 0), questionCompletionAction: { isCorrect in print(isCorrect) })
}
