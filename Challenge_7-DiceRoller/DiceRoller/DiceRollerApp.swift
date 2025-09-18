//
//  DiceRollerApp.swift
//  DiceRoller
//
//  Created by Georgi Ignatov on 7.08.25.
//

import SwiftData
import SwiftUI

@main
struct DiceRollerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Roll.self)
    }
}
