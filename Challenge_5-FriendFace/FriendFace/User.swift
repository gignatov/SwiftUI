//
//  User.swift
//  FriendFace
//
//  Created by Georgi Ignatov on 15.07.25.
//

import Foundation
import SwiftData

@Model
class User: Identifiable, Hashable, Codable {
    var id: String
    var name: String
    var age: Int
    var email: String
    var company: String
    var address: String
    var about: String
    var registrationDate: Date
    var tags: [String]
    var friends: [Friend]
    var isActive: Bool
    
    // MARK: Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case age
        case company
        case email
        case address
        case about
        case registrationDate = "registered"
        case tags
        case friends
        case isActive
    }
    
    // MARK: Init
    
    init(id: String,
         name: String,
         age: Int,
         email: String,
         company: String,
         address: String,
         about: String,
         registrationDate: Date,
         tags: [String],
         friends: [Friend],
         isActive: Bool) {
        self.id = id
        self.name = name
        self.age = age
        self.email = email
        self.company = company
        self.address = address
        self.about = about
        self.registrationDate = registrationDate
        self.tags = tags
        self.friends = friends
        self.isActive = isActive
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        email = try container.decode(String.self, forKey: .email)
        company = try container.decode(String.self, forKey: .company)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        registrationDate = try container.decode(Date.self, forKey: .registrationDate)
        tags = try container.decode([String].self, forKey: .tags)
        friends = try container.decode([Friend].self, forKey: .friends)
        isActive = try container.decode(Bool.self, forKey: .isActive)
    }
    
    // MARK: Encode
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(email, forKey: .email)
        try container.encode(company, forKey: .company)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(registrationDate, forKey: .registrationDate)
        try container.encode(tags, forKey: .tags)
        try container.encode(friends, forKey: .friends)
        try container.encode(isActive, forKey: .isActive)
    }
}
