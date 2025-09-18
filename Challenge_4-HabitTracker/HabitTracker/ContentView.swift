//
//  ContentView.swift
//  HabitTracker
//
//  Created by Georgi Ignatov on 20.06.25.
//

import SwiftUI

struct ContentView: View {
    @State private var activities = Activities()
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.indigo
                    .ignoresSafeArea()
                
                List {
                    ForEach(activities.items) { activity in
                        NavigationLink(value: activity) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(activity.title)
                                        .font(.headline)
                                        .foregroundStyle(.purple)
                                }
                                
                                Spacer()
                                
                                if activity.completionGoal == 0 ||
                                    activity.timesCompleted < activity.completionGoal {
                                    Text("^[\(activity.timesCompleted) time](inflect: true)")
                                        .font(.headline.bold())
                                        .foregroundStyle(colorForCompetionTimes(for: activity))
                                } else {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.green)
                                        .font(.headline.bold())
                                }
                            }
                        }
                        .listRowBackground(Color.white)
                    }
                    .onDelete(perform: removeItem)
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
            }
            .navigationDestination(for: Activity.self) { activity in
                ActivityView(activity: activity, activities: activities)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button(action: { isSheetPresented = true }, label: {
                    Label("Add Activity", systemImage: "plus")
                })
            }
            .sheet(isPresented: $isSheetPresented) {
                AddView(activities: activities)
            }
        }
        .preferredColorScheme(.dark)
        .tint(.primary)
    }
    
    func removeItem(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
    
    func colorForCompetionTimes(for activity: Activity) -> Color {
        let completedTimes = activity.timesCompleted
        let targetedCompetionTimes = activity.completionGoal
        
        if targetedCompetionTimes == 0 {
            return .green
        } else {
            if completedTimes < targetedCompetionTimes / 3 {
                return .red
            } else if completedTimes < targetedCompetionTimes * 2 / 3 {
                return .orange
            } else if completedTimes < targetedCompetionTimes {
                return .yellow
            } else {
                return .green
            }
        }
    }
}

#Preview {
    ContentView()
}
