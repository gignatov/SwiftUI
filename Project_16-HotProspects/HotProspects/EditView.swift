//
//  EditView.swift
//  HotProspects
//
//  Created by Georgi Ignatov on 24.07.25.
//

import SwiftData
import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    let prospect: Prospect
    @State private var name: String
    @State private var emailAddress: String
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Email addres", text: $emailAddress)
        }
        .toolbar {
            Button("Save") {
                modelContext.delete(prospect)
                let newProspect = Prospect(name: name,
                                           emailAddress: emailAddress,
                                           isContacted: prospect.isContacted)
                modelContext.insert(newProspect)
                dismiss()
            }
        }
    }
    
    init(prospect: Prospect) {
        self.prospect = prospect
        
        name = prospect.name
        emailAddress = prospect.emailAddress
    }
}

#Preview {
    let prospect = Prospect(name: "Test", emailAddress: "Test", isContacted: false)
    EditView(prospect: prospect)
}
