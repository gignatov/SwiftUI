//
//  NumberedButtonGrid.swift
//  Edutainment
//
//  Created by Georgi Ignatov on 20.05.25.
//

import SwiftUI

struct NumberedButtonGrid: View {
    
    // MARK: Constants
    
    private enum Constant {
        // Items
        static let minItemSize: CGFloat = 100
        static let itemsSpacing: CGFloat = 8
        // Buton
        static let buttonFontSizePropotion: CGFloat = 3 / 4
        static let buttonTextMinimumFontScale: CGFloat = 0.5
    }
    
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
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: Constant.minItemSize),
                             spacing: Constant.itemsSpacing)
                ], spacing: Constant.itemsSpacing) {
                    ForEach(range, id: \.self) { item in
                        Button {
                            buttonAction(item)
                        } label: {
                            Text("\(item)")
                                .frame(minWidth: Constant.minItemSize,
                                       maxWidth: .infinity,
                                       minHeight: Constant.minItemSize,
                                       maxHeight: .infinity)
                                .font(.system(size: Constant.minItemSize * Constant.buttonFontSizePropotion).weight(.black))
                                .minimumScaleFactor(Constant.buttonTextMinimumFontScale)
                                .aspectRatio(1, contentMode: .fit)
                        }
                        .buttonStyle(.primaryButton)
                    }
                }
                .padding()
        }
        .scrollBounceBehavior(.basedOnSize)
        .scrollIndicatorsFlash(onAppear: true)
    }
}

#Preview {
    NumberedButtonGrid(range: 2...12, buttonAction: { number in print("\(number)") })
}
