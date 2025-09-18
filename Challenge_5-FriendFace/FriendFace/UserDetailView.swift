//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Georgi Ignatov on 15.07.25.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(user.company)
                    .font(.title2)
                    .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                    Text(user.isActive ? "Online" : "Offline")
                        .font(.subheadline)
                }
                .foregroundStyle(user.isActive ? .green : .gray)
                .padding(.horizontal)
            }
            List {
                Section("General") {
                    VStack(alignment: .leading) {
                        Text("Age:")
                            .font(.headline)
                        Text("\(user.age)")
                    }
                    VStack(alignment: .leading) {
                        Text("Email:")
                            .font(.headline)
                        Text("\(user.email)")
                    }
                    VStack(alignment: .leading) {
                        Text("Address:")
                            .font(.headline)
                        Text(user.address)
                    }
                }
                
                Section("About") {
                    Text(user.about)
                }
                
                Section("Friends") {
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                }
                
                Section("Registered: \(user.registrationDate, style: .date)") {}
            }
            .navigationTitle(user.name)
        }
    }
}

#Preview {
    let example = User(id: "test",
                       name: "Shalom Shalom",
                       age: 69,
                       email: "shalom.shalom@example.com",
                       company: "Company",
                       address: "69 Here Street, New York",
                       about: "I am Shalom Shalom and I love to eat",
                       registrationDate: .now,
                       tags: ["Test", "Test2", "Test3"],
                       friends: [Friend(id: "test2", name: "Ivan Petrov"),
                                 Friend(id: "test3", name: "Petar Ivanov")],
                       isActive: true)
    
    UserDetailView(user: example)
}
