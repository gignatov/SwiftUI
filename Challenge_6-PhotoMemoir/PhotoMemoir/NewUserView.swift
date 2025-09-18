//
//  NewUserView.swift
//  PhotoMemoir
//
//  Created by Georgi Ignatov on 24.07.25.
//

import MapKit
import SwiftData
import SwiftUI

struct NewUserView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Bindable var user: User
    @Bindable var locationFetcher = LocationFetcher()
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $user.name)
            }
            
            Section {
                Image(imageData: user.imageData)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                if let location = locationFetcher.lastKnownLocation {
                    Text("Location")
                        .font(.headline)
                    
                    Map(initialPosition:
                            MapCameraPosition.region(
                                MKCoordinateRegion(center: location,
                                                   span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))) {
                                                       Marker("You met here", coordinate: location)
                                                   }
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
            
            Section {
                HStack(alignment: .center) {
                    Spacer()
                    Button("Save") {
                        user.latitude = locationFetcher.lastKnownLocation?.latitude
                        user.longitude = locationFetcher.lastKnownLocation?.longitude
                        
                        modelContext.insert(user)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
        .formStyle(.grouped)
        .onAppear {
            locationFetcher.start()
        }
    }
}

#Preview {
    NewUserView(user: User(name: "", imageData: Data()))
}
