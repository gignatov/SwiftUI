//
//  EditView.swift
//  BucketList
//
//  Created by Georgi Ignatov on 21.07.25.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    viewModel.save()
                    onSave(viewModel.location)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    init(viewModel: ViewModel, onSave: @escaping (Location) -> Void) {
        _viewModel = State(initialValue: viewModel)
        self.onSave = onSave
    }
}

#Preview {
    EditView(viewModel: .init(location: .example)) { _ in }
}
