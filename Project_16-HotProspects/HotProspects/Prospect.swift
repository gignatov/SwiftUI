//
//  Prospect.swift
//  HotProspects
//
//  Created by Georgi Ignatov on 24.07.25.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var timestamp: Date
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        
        timestamp = Date.now
    }
}
