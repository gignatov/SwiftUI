//
//  Location.swift
//  BucketList
//
//  Created by Georgi Ignatov on 21.07.25.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG
    static let example = Location(
        id: UUID(),
        name: "Sofia",
        description: "This is an example location.",
        latitude: 42.6977,
        longitude: 23.3219
    )
    #endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
