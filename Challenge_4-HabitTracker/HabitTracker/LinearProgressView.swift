//
//  LinearProgressView.swift
//  HabitTracker
//
//  Created by Georgi Ignatov on 20.06.25.
//

import SwiftUI

struct LinearProgressView: View {
    var value: Double

    var body: some View {
        Capsule().fill(.foreground.quaternary)
             .overlay(alignment: .leading) {
                 GeometryReader { proxy in
                     Capsule().fill(.tint)
                          .frame(width: proxy.size.width * value)
                 }
             }
             .clipShape(Capsule())
    }
}

#Preview {
    LinearProgressView(value: 0.4)
}
