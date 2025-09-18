//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Georgi Ignatov on 24.07.25.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
