//
//  AnsweredQuestionView.swift
//  Edutainment
//
//  Created by Georgi Ignatov on 27.05.25.
//

import SwiftUI

struct AnsweredQuestionView: View {
    
    // MARK: Constant
    
    private enum Constant {
        static let imageSize: CGFloat = 100
        static let animationDuration: TimeInterval = 1.25
        static let animationBounce: CGFloat = 0.6
    }
    
    // MARK: Properties
    
    private let isCorrect: Bool
    private let animationCompletion: () -> Void
    
    // MARK: State
    
    @State private var animationAmount: CGFloat = 0
    @State private var scaleAmount: CGFloat = 0
    
    // MARK: Init
    
    init(isCorrect: Bool, animationCompletion: @escaping () -> Void) {
        self.isCorrect = isCorrect
        self.animationCompletion = animationCompletion
    }
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            if isCorrect {
                Color.green
            } else {
                Color.red
            }
            VStack {
                Image(systemName: isCorrect ? "checkmark" : "xmark")
                    .font(.system(size: Constant.imageSize).weight(.heavy))
                    .foregroundColor(.white)
                    .scaleEffect(scaleAmount)
                    .animation(.spring(duration: Constant.animationDuration,
                                       bounce: Constant.animationBounce),
                               value: animationAmount)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                scaleAmount = 1
                animationAmount = 1
            } completion: {
                withAnimation {
                    scaleAmount = 0
                } completion: {
                    animationAmount = 0
                    animationCompletion()
                }
            }
        }
    }
}

#Preview {
    AnsweredQuestionView(isCorrect: true) {}
}
