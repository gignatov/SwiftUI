//
//  GameOverView.swift
//  Edutainment
//
//  Created by Georgi Ignatov on 21.05.25.
//

import SwiftUI

struct GameOverView: View {
    
    // MARK: Constants
    
    private enum Constant {
        static let questionsShadowRadius: CGFloat = 8
    }
    
    // MARK: Properties
    
    private var correctAnswers: Int
    private var totalQuestions: Int
    private var buttonAction: () -> Void
    
    // MARK: Init
    
    init (correctAnswers: Int, totalQuestions: Int, buttonAction: @escaping () -> Void) {
        self.correctAnswers = correctAnswers
        self.totalQuestions = totalQuestions
        self.buttonAction = buttonAction
    }
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Spacer()
            Text("Good job!")
                .font(.largeTitle.bold())
                .padding()
                .multilineTextAlignment(.center)
                .foregroundStyle(.indigo)
            
            Text("You got \(correctAnswers)/\(totalQuestions) questions right!")
                .font(.largeTitle.bold())
                .padding()
                .multilineTextAlignment(.center)
                .foregroundStyle(.yellow).shadow(radius: Constant.questionsShadowRadius)
            
            Spacer()
            Button {
                buttonAction()
            } label: {
                Text("Play again")
                    .font(.largeTitle.bold())
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
            }
            .buttonStyle(.primaryButton)
            Spacer()
        }
    }
}

#Preview {
    GameOverView(correctAnswers: 4, totalQuestions: 20, buttonAction: {})
}
