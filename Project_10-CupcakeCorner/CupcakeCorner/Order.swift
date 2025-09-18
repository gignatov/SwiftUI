//
//  Order.swift
//  CupcakeCorner
//
//  Created by Georgi Ignatov on 30.06.25.
//

import Foundation

@Observable
class Order: Codable {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
    // MARK: - Static
    
    static let types = ["Vanilla", "Chocolate", "Strawberry", "Rainbow"]
    
    // MARK: - Properties
    
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        !name.isEmptyString && !streetAddress.isEmptyString && !city.isEmptyString && !zip.isEmptyString
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50 per cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) * 0.5
        }
        
        return cost
    }
    
    // MARK: - Init
    
    init() {
        if let name = UserDefaults.standard.string(forKey: "name") {
            self.name = name
        }
        if let streetAddress = UserDefaults.standard.string(forKey: "streetAddress") {
            self.streetAddress = streetAddress
        }
        if let city = UserDefaults.standard.string(forKey: "city") {
            self.city = city
        }
        if let zip = UserDefaults.standard.string(forKey: "zip") {
            self.zip = zip
        }
    }
}
