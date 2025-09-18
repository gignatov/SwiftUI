//
//  Friend.swift
//  FriendFace
//
//  Created by Georgi Ignatov on 15.07.25.
//

import Foundation
import SwiftData

@Model
class Friend: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    
    // MARK: Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    // MARK: Init
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
    // MARK: Encode
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
