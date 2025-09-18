//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Georgi Ignatov on 14.07.25.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
