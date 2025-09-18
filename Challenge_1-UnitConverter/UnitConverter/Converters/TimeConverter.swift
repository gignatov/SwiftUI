//
//  TimeConverter.swift
//  UnitConverter
//
//  Created by Georgi Ignatov on 17.01.25.
//

import Foundation

struct TimeConverter {
    
    // MARK: - Shared
    
    static let shared = TimeConverter()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Public
        
    func convert(from fromUnit: Time, to toUnit: Time, value: Double) -> Double {
        let primaryValue = convertToPrimaryUnit(from: fromUnit, value: value)
        let convertedValue = convertFromPrimaryUnit(to: toUnit, value: primaryValue)
        return convertedValue
    }
    
    // MARK: - Helpers
    
    private func convertToPrimaryUnit(from unit: Time, value: Double) -> Double {
        switch unit {
        case .seconds:
            return value
        case .minutes:
            return value * 60
        case .hours:
            return value * 3600
        case .days:
            return value * 86400
        }
    }
    
    private func convertFromPrimaryUnit(to unit: Time, value: Double) -> Double {
        switch unit {
        case .seconds:
            return value
        case .minutes:
            return value / 60
        case .hours:
            return value / 3600
        case .days:
            return value / 86400
        }
    }
}
