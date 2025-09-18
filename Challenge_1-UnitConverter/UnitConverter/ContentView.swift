//
//  ContentView.swift
//  UnitConverter
//
//  Created by Georgi Ignatov on 17.01.25.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - State Properties
    
    @State private var selectedMetric = ""
    @State private var selectedFromUnit = ""
    @State private var selectedToUnit = ""
    @State private var fromValue: Double?
    
    @FocusState private var isFieldFocused: Bool
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Metric", selection: $selectedMetric) {
                        ForEach(Metric.allCases, id: \.rawValue) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                }
                
                if let metric = Metric(rawValue: selectedMetric) {
                    makeUnitsSection(metric: metric)
                    makeConversionSection(metric: metric)
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                if isFieldFocused {
                    Button("Done") {
                        isFieldFocused = false
                    }
                }
            }
        }
    }
}

// MARK: - View

private extension ContentView {
    func makeUnitsSection(metric: Metric) -> some View {
        Section("Units") {
            VStack {
                Picker("From", selection: $selectedFromUnit) {
                    switch metric {
                    case .temperature:
                        ForEach(Temperature.allCases, id: \.rawValue) {
                            Text($0.shortForm)
                        }
                    case .length:
                        ForEach(Length.allCases, id: \.rawValue) {
                            Text($0.shortForm)
                        }
                    case .time:
                        ForEach(Time.allCases, id: \.rawValue) {
                            Text($0.shortForm)
                        }
                    case .volume:
                        ForEach(Volume.allCases, id: \.rawValue) {
                            Text($0.shortForm)
                        }
                    }
                }
                .pickerStyle(.segmented)
                
                Text("To")
                Picker("To", selection: $selectedToUnit) {
                    switch metric {
                    case .temperature:
                        ForEach(Temperature.allCases, id: \.rawValue) {
                            Text($0.shortForm)
                        }
                    case .length:
                        ForEach(Length.allCases, id: \.rawValue) {
                            Text($0.shortForm)
                        }
                    case .time:
                        ForEach(Time.allCases, id: \.rawValue) {
                            Text($0.shortForm)
                        }
                    case .volume:
                        ForEach(Volume.allCases, id: \.rawValue) {
                            Text($0.shortForm)
                        }
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }
    
    func makeConversionSection(metric: Metric) -> some View {
        switch metric {
        case .temperature:
            if let fromUnit = Temperature(rawValue: selectedFromUnit),
               let toUnit = Temperature(rawValue: selectedToUnit) {
                return VStack {
                    Section("Enter value in \(fromUnit.rawValue):") {
                        TextField("Value", value: $fromValue, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($isFieldFocused)
                            .onAppear {
                                isFieldFocused = true
                            }
                            .onChange(of: isFieldFocused) {
                                if isFieldFocused {
                                    fromValue = nil
                                }
                            }
                            .multilineTextAlignment(.center)
                    }
                    
                    if let fromValue, fromValue >= 0.0 {
                        Section("Value in \(toUnit.rawValue):") {
                            let value = TemperatureConverter.shared.convert(from: fromUnit, to: toUnit, value: fromValue)
                            Text(value.formatted())
                        }
                    }
                }
            }
        case .length:
            if let fromUnit = Length(rawValue: selectedFromUnit),
               let toUnit = Length(rawValue: selectedToUnit) {
                return VStack {
                    Section("Enter value in \(fromUnit.rawValue):") {
                        TextField("Value", value: $fromValue, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($isFieldFocused)
                            .onAppear {
                                isFieldFocused = true
                            }
                            .onChange(of: isFieldFocused) {
                                if isFieldFocused {
                                    fromValue = nil
                                }
                            }
                            .multilineTextAlignment(.center)
                    }
                    
                    if let fromValue, fromValue >= 0.0 {
                        Section("Value in \(toUnit.rawValue):") {
                            let value = LengthConverter.shared.convert(from: fromUnit, to: toUnit, value: fromValue)
                            Text(value.formatted())
                        }
                    }
                }
            }
        case .time:
            if let fromUnit = Time(rawValue: selectedFromUnit),
               let toUnit = Time(rawValue: selectedToUnit) {
                return VStack {
                    Section("Enter value in \(fromUnit.rawValue):") {
                        TextField("Value", value: $fromValue, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($isFieldFocused)
                            .onAppear {
                                isFieldFocused = true
                            }
                            .onChange(of: isFieldFocused) {
                                if isFieldFocused {
                                    fromValue = nil
                                }
                            }
                            .multilineTextAlignment(.center)
                    }
                    
                    if let fromValue, fromValue >= 0.0 {
                        Section("Value in \(toUnit.rawValue):") {
                            let value = TimeConverter.shared.convert(from: fromUnit, to: toUnit, value: fromValue)
                            Text(value.formatted())
                        }
                    }
                }
            }
        case .volume:
            if let fromUnit = Volume(rawValue: selectedFromUnit),
               let toUnit = Volume(rawValue: selectedToUnit) {
                return VStack {
                    Section("Enter value in \(fromUnit.rawValue):") {
                        TextField("Value", value: $fromValue, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($isFieldFocused)
                            .onAppear {
                                isFieldFocused = true
                            }
                            .onChange(of: isFieldFocused) {
                                if isFieldFocused {
                                    fromValue = nil
                                }
                            }
                            .multilineTextAlignment(.center)
                    }
                    
                    if let fromValue, fromValue >= 0.0 {
                        Section("Value in \(toUnit.rawValue):") {
                            let value = VolumeConverter.shared.convert(from: fromUnit, to: toUnit, value: fromValue)
                            Text(value.formatted())
                        }
                    }
                }
            }
        }
        
        return EmptyView()
    }
}

#Preview {
    ContentView()
}
