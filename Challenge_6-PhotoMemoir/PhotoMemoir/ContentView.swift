//
//  ContentView.swift
//  PhotoMemoir
//
//  Created by Georgi Ignatov on 24.07.25.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\User.name)
    ]) var users: [User]
    
    @State private var images: [Image] = []
    @State private var selectedItem: PhotosPickerItem?
    @State private var newUser: User?
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(users) { user in
                        ZStack {
                            // Patch since we can't hide the chevron (will be changed after WWDC25)
                            NavigationLink(user.name, value: user)
                            .opacity(0)
                            
                            VStack {
                                Text(user.name)
                                    .font(.title2.bold())
                                Image(imageData: user.imageData)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    .onDelete(perform: deleteUsers)
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                }
                .navigationTitle("Photo Memoir")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Label("Select Photo", systemImage: "photo.badge.plus")
                        }
                    }
                }
                .listStyle(.inset)
                .buttonStyle(.plain)
                .onChange(of: selectedItem) { prepareNewUser() }
                .sheet(item: $newUser) { newUser in
                    NewUserView(user: newUser)
                        .onDisappear {
                            selectedItem = nil
                        }
                }
                .navigationDestination(for: User.self) { user in
                    UserDetailsView(user: user)
                }
            }
        }
    }
    
    func prepareNewUser() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {
                return
            }
            
            newUser = User(name: "", imageData: imageData)
        }
    }
    
    func deleteUsers(at offsets: IndexSet) {
        for offset in offsets {
            let user = users[offset]
            modelContext.delete(user)
        }
    }
}

#Preview {
    ContentView()
}
