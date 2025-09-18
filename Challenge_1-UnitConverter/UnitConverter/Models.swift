//
//  Models.swift
//  UnitConverter
//
//  Created by Georgi Ignatov on 17.01.25.
//

import Foundation

enum Metric: String, CaseIterable {
    case temperature
    case length
    case time
    case volume
}

enum Temperature: String, CaseIterable {
    case celsius
    case fahrenheit
    case kelvin
    
    var shortForm: String {
        switch self {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        case .kelvin:
            return "K"
        }
    }
}

enum Length: String, CaseIterable {
    case meters
    case kilometers
    case feet
    case yards
    case miles
    
    var shortForm: String {
        switch self {
        case .meters:
            "m"
        case .kilometers:
            "km"
        case .feet:
            "ft"
        case .yards:
            "yd"
        case .miles:
            "mi"
        }
    }
}

enum Time: String, CaseIterable {
    case seconds
    case minutes
    case hours
    case days
    
    var shortForm: String {
        switch self {
        case .seconds:
            "sec"
        case .minutes:
            "min"
        case .hours:
            "hr"
        case .days:
            "day"
        }
    }
}

enum Volume: String, CaseIterable {
    case milliliters
    case liters
    case cups
    case pints
    case gallons
    
    var shortForm: String {
        switch self {
        case .milliliters:
            "ml"
        case .liters:
            "l"
        case .cups:
            "cup"
        case .pints:
            "pt"
        case .gallons:
            "gal"
        }
    }
}
