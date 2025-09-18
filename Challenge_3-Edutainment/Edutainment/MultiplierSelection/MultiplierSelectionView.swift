//
//  MultiplierSelectionView.swift
//  Edutainment
//
//  Created by Georgi Ignatov on 20.05.25.
//

import SwiftUI

struct MultiplierSelectionView: View {
    
    // MARK: Properties
    
    private let range: ClosedRange<Int>
    private let buttonAction: (Int) -> Void
    
    // MARK: Init
    
    init(range: ClosedRange<Int>, buttonAction: @escaping (Int) -> Void) {
        self.range = range
        self.buttonAction = buttonAction
    }
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Spacer()
            Text("Which number would you like to multiply by?")
                .font(.largeTitle.bold())
                .padding()
                .multilineTextAlignment(.center)
                .foregroundStyle(.indigo)
            NumberedButtonGrid(range: range, buttonAction: buttonAction)
        }
    }
}

#Preview {
    MultiplierSelectionView(range: 2...12, buttonAction: { number in print("\(number)") })
}
