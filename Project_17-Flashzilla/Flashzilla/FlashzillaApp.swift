//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Georgi Ignatov on 5.08.25.
//

import SwiftData
import SwiftUI

@main
struct FlashzillaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Card.self)
    }
}
