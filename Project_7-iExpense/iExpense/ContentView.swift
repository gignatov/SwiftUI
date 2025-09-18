//
//  ContentView.swift
//  iExpense
//
//  Created by Georgi Ignatov on 29.05.25.
//

import SwiftData
import SwiftUI

@Model
class ExpenseItem: Identifiable {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}

enum ExpenseType: String, CaseIterable, Identifiable {
    case personal = "Personal"
    case business = "Business"
    
    var id: Self { self }
}

struct ContentView: View {        
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    @State private var typeFilter: ExpenseType?
    
    var body: some View {
        NavigationStack {
            ExpensesView(typeFilter: typeFilter, sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView()
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\ExpenseItem.name),
                                SortDescriptor(\ExpenseItem.amount)
                            ])
                        
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\ExpenseItem.amount),
                                SortDescriptor(\ExpenseItem.name)
                            ])
                    }
                }
                
                Menu("Type", systemImage: "line.3.horizontal.decrease.circle") {
                    Picker("Type", selection: $typeFilter) {
                        Text("All").tag(nil as ExpenseType?)
                        Text("Personal").tag(ExpenseType.personal)
                        Text("Business").tag(ExpenseType.business)
                    }
                }
            }
        }
    }
    
   
    
    
}

#Preview {
    ContentView()
}
