//
//  AddBookView.swift
//  Bookworm
//
//  Created by Georgi Ignatov on 3.07.25.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title,
                                           author: author,
                                           genre: genre,
                                           review: review,
                                           rating: rating,
                                           date: .now)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(disableSaveButton())
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func disableSaveButton() -> Bool {
        title.isEmpty || author.isEmpty
    }
}

#Preview {
    AddBookView()
}
