//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Georgi Ignatov on 20.06.25.
//

import SwiftUI

struct ActivityView: View {
    var activity: Activity
    var activities: Activities
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.indigo
                    .ignoresSafeArea()
                
                VStack() {
                    if !activity.description.isEmpty {
                        ZStack(alignment: .topLeading) {
                            Color.white
                                .cornerRadius(12)
                            
                            Text(activity.description)
                                .font(.title3.bold())
                                .foregroundStyle(.purple)
                                .multilineTextAlignment(.leading)
                                .padding(16)
                        }
                        .padding(16)
                    }
                    
                    if activity.completionGoal > 0 {
                        Text("Goal progress:")
                            .font(.title.weight(.semibold))
                        
                        if activity.timesCompleted >= activity.completionGoal {
                            Text("Completed")
                                .font(.title.weight(.semibold))
                                .foregroundStyle(.green)
                        } else {
                            Text("\(activity.timesCompleted) / \(activity.completionGoal)")
                                .font(.title.weight(.semibold))
                        }
                        
                        LinearProgressView(value: Double(activity.timesCompleted) / Double(activity.completionGoal))
                            .tint(.purple)
                            .frame(height: 16)
                            .padding(16)
                    } else {
                        Text("Completed ^[\(activity.timesCompleted) time](inflect: true)")
                            .font(.title.weight(.semibold))
                    }
                    
                    HStack(alignment: .center) {
                        Button(action: competeTap) {
                            Text("Complete")
                                .padding(16)
                                .font(.title.bold())
                                .foregroundStyle(.white)
                                .background(.purple)
                                .cornerRadius(16)
                        }
                        .padding(16)
                    }
                }
            }
            .navigationTitle(activity.title)
        }
    }
    
    func competeTap() {
        if let index = activities.items.firstIndex(of: activity) {
            activity.timesCompleted += 1
            activities.items[index] = activity
        }
    }
}

#Preview {
    let activity = Activity(title: "Test",
                            description: "",
                            completionGoal: 0,
                            timesCompleted: 0)
    let activities = Activities()
    ActivityView(activity: activity, activities: activities)
        .preferredColorScheme(.dark)
}
