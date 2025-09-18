//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Georgi Ignatov on 29.05.25.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
