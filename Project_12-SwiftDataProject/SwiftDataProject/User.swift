//
//  User.swift
//  SwiftDataProject
//
//  Created by Georgi Ignatov on 14.07.25.
//

import Foundation
import SwiftData

@Model
class User: Identifiable {
    var name = "Anonymous"
    var city = "Unknown"
    var joinDate = Date.now
    @Relationship(deleteRule: .cascade) var jobs: [Job]? = [Job]()
    
    var unwrappedJobs: [Job] {
        jobs ?? []
    }
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
