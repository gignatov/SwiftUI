//
//  View+dismissKeyboard.swift
//  DiceRoller
//
//  Created by Georgi Ignatov on 7.08.25.
//

import SwiftUI

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
