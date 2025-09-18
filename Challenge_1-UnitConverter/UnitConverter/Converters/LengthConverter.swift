//
//  LengthConverter.swift
//  UnitConverter
//
//  Created by Georgi Ignatov on 17.01.25.
//

import Foundation

struct LengthConverter {
    
    // MARK: - Shared
    
    static let shared = LengthConverter()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Public
        
    func convert(from fromUnit: Length, to toUnit: Length, value: Double) -> Double {
        let primaryValue = convertToPrimaryUnit(from: fromUnit, value: value)
        let convertedValue = convertFromPrimaryUnit(to: toUnit, value: primaryValue)
        return convertedValue
    }
    
    // MARK: - Helpers
    
    private func convertToPrimaryUnit(from unit: Length, value: Double) -> Double {
        switch unit {
        case .meters:
            return value
        case .kilometers:
            return value / 1000
        case .feet:
            return value / 3.281
        case .yards:
            return value / 1.094
        case .miles:
            return value * 1609
        }
    }
    
    private func convertFromPrimaryUnit(to unit: Length, value: Double) -> Double {
        switch unit {
        case .meters:
            return value
        case .kilometers:
            return value * 1000
        case .feet:
            return value * 3.281
        case .yards:
            return value * 1.094
        case .miles:
            return value / 1609
        }
    }
}
