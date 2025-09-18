//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Georgi Ignatov on 23.07.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(.character)
            .accessibilityHidden(true)
    }
}

#Preview {
    ContentView()
}
