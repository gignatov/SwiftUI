//
//  ContentView.swift
//  FriendFace
//
//  Created by Georgi Ignatov on 15.07.25.
//

import SwiftData
import SwiftUI

private enum Constant {
    static let dataURLString = "https://www.hackingwithswift.com/samples/friendface.json"
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\User.isActive, order: .reverse),
        SortDescriptor(\User.name)
    ]) var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                ZStack {
                    // Patch since we can't hide the chevron (will be changed after WWDC25)
                    NavigationLink(user.name, value: user)
                    .opacity(0)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.company)
                                .font(.caption)
                        }
                        Spacer()
                        Image(systemName: "circle.fill")
                            .foregroundStyle(user.isActive ? .green : .gray)
                            .font(.headline)
                    }
                }
            }
            .task {
                await loadData()
            }
            .navigationTitle("FriendFace")
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
        }
    }
}

// MARK: - Helpers

private extension ContentView {
    func loadData() async {
        guard users.isEmpty else { return }
        
        guard let url = URL(string: Constant.dataURLString) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                decodedResponse.forEach {
                    modelContext.insert($0)
                }
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
