//
//  Activities.swift
//  HabitTracker
//
//  Created by Georgi Ignatov on 20.06.25.
//

import Foundation

@Observable
class Activity: Identifiable, Codable, Hashable, ObservableObject {
    var id: UUID
    let title: String
    let description: String
    let completionGoal: Int
    var timesCompleted: Int
    
    init(id: UUID = UUID(), title: String, description: String, completionGoal: Int, timesCompleted: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.completionGoal = completionGoal
        self.timesCompleted = timesCompleted
    }
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@Observable
class Activities {
    var items: [Activity] {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(data, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Activities"),
           let activities = try? JSONDecoder().decode([Activity].self, from: data) {
            items = activities
        } else {
            items = []
        }
    }
}
