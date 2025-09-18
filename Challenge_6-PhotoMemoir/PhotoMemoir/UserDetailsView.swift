//
//  UserDetailsView.swift
//  PhotoMemoir
//
//  Created by Georgi Ignatov on 24.07.25.
//

import MapKit
import SwiftUI

struct UserDetailsView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let user: User
    
    var body: some View {
        List {
            Section {
                Image(imageData: user.imageData)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .navigationTitle(user.name)
                    .toolbar {
                        ToolbarItem(placement: .destructiveAction) {
                            Button("Delete", systemImage: "trash.circle") {
                                modelContext.delete(user)
                                dismiss()
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
            }
            
            if let latitude = user.latitude, let longitude = user.longitude {
                let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                Section("Where you met") {
                    Map(initialPosition:
                            MapCameraPosition.region(
                                MKCoordinateRegion(center: location,
                                                   span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))) {
                                                       Marker("You met here", coordinate: location)
                                                   }
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    UserDetailsView(user: User(name: "Test", imageData: Data()))
}
