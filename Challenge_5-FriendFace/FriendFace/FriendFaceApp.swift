//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Georgi Ignatov on 15.07.25.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
