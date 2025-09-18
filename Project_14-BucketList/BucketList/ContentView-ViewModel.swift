//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Georgi Ignatov on 21.07.25.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        private(set) var isUnlocked = false
        
        private(set) var alertTitle = ""
        private(set) var alertMessage = ""
        
        var selectedPlace: Location?
        var showingAlert = false
        
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(),
                                       name: "New location",
                                       description: "",
                                       latitude: point.latitude,
                                       longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func updateLocation(_ location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.alertTitle = "Authentication failed"
                        self.alertMessage = error?.localizedDescription ?? "Please try again."
                        self.showingAlert = true
                    }
                }
            } else {
                self.alertTitle = "Biometrics unavailable"
                self.alertMessage = "Can't access content because this device doesn't support biometrics authentication."
                self.showingAlert = true
            }
        }
    }
}
