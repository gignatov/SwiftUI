//
//  PrimaryButtonStyle.swift
//  Edutainment
//
//  Created by Georgi Ignatov on 27.05.25.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    // MARK: Constants
    
    private enum Constant {
        static let cornerRadius: CGFloat = 16
        static let shadowRadius: CGFloat = 2
        static let shadowXOffset: CGFloat = 4
        static let shadowYOffset: CGFloat = 4
    }
    
    // MARK: Factory
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(.pink)
            .foregroundStyle(.orange)
            .cornerRadius(Constant.cornerRadius)
            .shadow(radius: Constant.shadowRadius,
                    x: Constant.shadowXOffset,
                    y: Constant.shadowYOffset)
    }
}

// MARK: - Static

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primaryButton: PrimaryButtonStyle { .init() }
}
