//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Georgi Ignatov on 6.04.25.
//

import SwiftUI

struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.blue)
    }
}

extension View {
    func largeBlueFont() -> some View {
        modifier(LargeBlueFont())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .largeBlueFont()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
