//
//  ContentView.swift
//  BucketList
//
//  Created by Georgi Ignatov on 21.07.25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.7, longitude: 25.3),
                           span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7))
    )
    
    @State private var viewModel = ViewModel()
    @State private var showingStyles = false
    @State private var mapStyle: MapStyle = .standard
    
    var body: some View {
        VStack {
            if viewModel.isUnlocked {
                ZStack {
                    MapReader { proxy in
                        Map(initialPosition: startPosition) {
                            ForEach(viewModel.locations) { location in
                                Annotation(location.name, coordinate: location.coordinate) {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .onLongPressGesture(minimumDuration: 0.2) {
                                            viewModel.selectedPlace = location
                                        }
                                }
                            }
                        }
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                viewModel.addLocation(at: coordinate)
                            }
                        }
                        .sheet(item: $viewModel.selectedPlace) { place in
                            EditView(viewModel: .init(location: place)) {
                                viewModel.updateLocation($0)
                            }
                        }
                        .mapStyle(mapStyle)
                    }
                    
                    Button {
                        showingStyles = true
                    } label: {
                        Image(systemName: "map")
                    }
                    .padding()
                    .background(Material.thin)
                    .foregroundStyle(.primary)
                    .clipShape(.capsule)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .confirmationDialog("Map style", isPresented: $showingStyles) {
                        Button("Standard") { setStyle(.standard) }
                        Button("Hybrid") { setStyle(.hybrid) }
                        
                        Button("Cancel", role: .cancel) { }
                    }
                }
            } else {
                Button("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
            Button("OK") { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    func setStyle(_ style: MapStyle) {
        mapStyle = style
    }
}

#Preview {
    ContentView()
}
