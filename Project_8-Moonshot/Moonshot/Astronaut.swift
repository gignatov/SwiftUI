//
//  Astronaut.swift
//  Moonshot
//
//  Created by Georgi Ignatov on 2.06.25.
//

import Foundation

struct Astronaut: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
}
