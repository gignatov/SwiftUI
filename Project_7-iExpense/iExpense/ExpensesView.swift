//
//  ExpensesView.swift
//  iExpense
//
//  Created by Georgi Ignatov on 14.07.25.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    var body: some View {
        List {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(colorForItemAmount(item.amount))
                }
                .accessibilityElement()
                .accessibilityLabel("\(item.name): \(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                .accessibilityHint(item.type)
            }
            .onDelete(perform: removeItems)
        }
    }
    
    init(typeFilter: ExpenseType?, sortOrder: [SortDescriptor<ExpenseItem>]) {
        if let type = typeFilter?.rawValue {
            _expenses = Query(filter: #Predicate<ExpenseItem> { item in
                if item.type == type {
                    return true
                } else {
                    return false
                }
            }, sort: sortOrder)
        } else {
            _expenses = Query(sort: sortOrder)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
    
    func colorForItemAmount(_ amount: Double) -> Color {
        if amount < 10 {
            return .green
        } else if amount < 100 {
            return .yellow
        } else {
            return .red
        }
    }
}

#Preview {
    ExpensesView(typeFilter: nil, sortOrder: [SortDescriptor(\ExpenseItem.name)])
}
