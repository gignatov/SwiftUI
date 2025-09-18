//
//  NumberOfQuestionsSelectionView.swift
//  Edutainment
//
//  Created by Georgi Ignatov on 20.05.25.
//

import SwiftUI

struct NumberOfQuestionsSelectionView: View {
    
    // MARK: Constants
    
    private enum Constant {
        static let buttonFontSize: CGFloat = 75
    }
    
    // MARK: Properties
    
    private let numberOfQuestionOptions: [Int]
    private let buttonAction: (Int) -> Void
    
    // MARK: Init
    
    init(numberOfQuestionOptions: [Int], buttonAction: @escaping (Int) -> Void) {
        self.numberOfQuestionOptions = numberOfQuestionOptions
        self.buttonAction = buttonAction
    }
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Spacer()
            Text("How many questions do you want to solve?")
                .font(.largeTitle.bold())
                .padding()
                .multilineTextAlignment(.center)
                .foregroundStyle(.indigo)
            List {
                ForEach(0..<numberOfQuestionOptions.count, id: \.self) { index in
                    Button {
                        buttonAction(numberOfQuestionOptions[index])
                    } label: {
                        Text("\(numberOfQuestionOptions[index])")
                            .frame(maxWidth: .infinity,
                                   maxHeight: .infinity)
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

#Preview {
    NumberOfQuestionsSelectionView(numberOfQuestionOptions: [5, 10, 20], buttonAction: { number in print("\(number)") })
}
