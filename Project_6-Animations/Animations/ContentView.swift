//
//  ContentView.swift
//  Animations
//
//  Created by Georgi Ignatov on 14.05.25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation(.spring(duration: 1, bounce: 0.5)) {
                    animationAmount += 360
                }
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(.degrees(animationAmount),
                              axis: (x: 0, y: 1, z: 0))
        }
    }
}

#Preview {
    ContentView()
}
