//
//  VolumeConverter.swift
//  UnitConverter
//
//  Created by Georgi Ignatov on 17.01.25.
//

import Foundation

struct VolumeConverter {
    
    // MARK: - Shared
    
    static let shared = VolumeConverter()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Public
        
    func convert(from fromUnit: Volume, to toUnit: Volume, value: Double) -> Double {
        let primaryValue = convertToPrimaryUnit(from: fromUnit, value: value)
        let convertedValue = convertFromPrimaryUnit(to: toUnit, value: primaryValue)
        return convertedValue
    }
    
    // MARK: - Helpers
    
    private func convertToPrimaryUnit(from unit: Volume, value: Double) -> Double {
        switch unit {
        case .milliliters:
            return value
        case .liters:
            return value * 1000
        case .cups:
            return value * 236.6
        case .pints:
            return value * 473.2
        case .gallons:
            return value * 3785
        }
    }
    
    private func convertFromPrimaryUnit(to unit: Volume, value: Double) -> Double {
        switch unit {
        case .milliliters:
            return value
        case .liters:
            return value / 1000
        case .cups:
            return value / 236.6
        case .pints:
            return value / 473.2
        case .gallons:
            return value / 3785
        }
    }
}
