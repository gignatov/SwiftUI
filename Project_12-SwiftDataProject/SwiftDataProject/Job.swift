//
//  Job.swift
//  SwiftDataProject
//
//  Created by Georgi Ignatov on 14.07.25.
//

import Foundation
import SwiftData

@Model
class Job {
    var name = "None"
    var priority = 1
    var owner: User?
    
    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
