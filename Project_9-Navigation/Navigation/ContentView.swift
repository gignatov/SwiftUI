//
//  ContentView.swift
//  Navigation
//
//  Created by Georgi Ignatov on 5.06.25.
//

import SwiftUI

@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
          print("Failed to save navigation data")
        }
    }
}

struct DetailView: View {
    var number: Int
    @Binding var pathStore: PathStore
    
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1..<1000))
            .navigationTitle(Text("Number: \(number)"))
            .toolbar {
                Button("Home") {
                    pathStore.path = NavigationPath()
                }
            }
    }
}

struct ContentView: View {
    @State private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0, pathStore: $pathStore)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, pathStore: $pathStore)
                }
        }
    }
}

#Preview {
    ContentView()
}
