//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Georgi Ignatov on 1.09.25.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        let resortsArray = UserDefaults.standard.array(forKey: key) as? [String] ?? []
        resorts = Set(resortsArray)
    }
    
    func contain(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        let resortsArray = Array(resorts)
        UserDefaults.standard.setValue(resortsArray, forKey: key)
    }
}
