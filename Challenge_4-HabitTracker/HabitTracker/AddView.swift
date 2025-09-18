//
//  AddView.swift
//  HabitTracker
//
//  Created by Georgi Ignatov on 20.06.25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title = "New Activity"
    @State private var description = ""
    @State private var completionGoal = 0
    
    var activities: Activities
        
    var body: some View {
        NavigationStack {
            ZStack {
                Color.indigo
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    ZStack(alignment: .topLeading) {
                        Color.white
                            .cornerRadius(12)
                        
                        TextField("", text: $description, prompt: Text("Description").foregroundColor(.gray))
                            .font(.subheadline)
                            .foregroundStyle(.purple)
                            .padding(16)
                            .tint(.purple)
                    }
                    .padding(16)
                    
                    Text("How many times do you want to complete this activity?")
                        .font(.title3.weight(.semibold))
                        .padding(16)
                    
                    Picker("", selection: $completionGoal) {
                        ForEach(0..<101) {
                            if $0 == 0 {
                                Text("∞")
                                    .font(.title.bold())
                            } else {
                                Text("\($0)")
                                    .font(.title2.bold())
                            }
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding(16)
                }
            }
            .navigationTitle($title)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let activity = Activity(title: title,
                                                description: description,
                                                completionGoal: completionGoal,
                                                timesCompleted: 0)
                        activities.items.append(activity)
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .tint(.primary)
        }
    }
}

#Preview {
    AddView(activities: .init())
        .preferredColorScheme(.dark)
}

