//
//  TemperatureConverter.swift
//  UnitConverter
//
//  Created by Georgi Ignatov on 17.01.25.
//

import Foundation

struct TemperatureConverter {
    
    // MARK: - Shared
    
    static let shared = TemperatureConverter()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Public
        
    func convert(from fromUnit: Temperature, to toUnit: Temperature, value: Double) -> Double {
        let primaryValue = convertToPrimaryUnit(from: fromUnit, value: value)
        let convertedValue = convertFromPrimaryUnit(to: toUnit, value: primaryValue)
        return convertedValue
    }
    
    // MARK: - Helpers
    
    private func convertToPrimaryUnit(from unit: Temperature, value: Double) -> Double {
        switch unit {
        case .celsius:
            return value
        case .fahrenheit:
            return (value - 32) * (5/9)
        case .kelvin:
            return value - 273.15
        }
    }
    
    private func convertFromPrimaryUnit(to unit: Temperature, value: Double) -> Double {
        switch unit {
        case .celsius:
            return value
        case .fahrenheit:
            return value * (9/5) + 32
        case .kelvin:
            return value + 273.15
        }
    }
}
