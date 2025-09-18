//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Georgi Ignatov on 3.07.25.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
