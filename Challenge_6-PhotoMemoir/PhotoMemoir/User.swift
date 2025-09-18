//
//  User.swift
//  PhotoMemoir
//
//  Created by Georgi Ignatov on 24.07.25.
//

import Foundation
import SwiftData

@Model
class User: Identifiable {
    var id: UUID
    var name: String
    @Attribute(.externalStorage) var imageData: Data
    var latitude: Double?
    var longitude: Double?
    
    init(name: String, imageData: Data, latitude: Double? = nil, longitude: Double? = nil) {
        self.id = UUID()
        self.name = name
        self.imageData = imageData
        self.latitude = latitude
        self.longitude = longitude
    }
}
