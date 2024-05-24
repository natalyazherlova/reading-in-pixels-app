//
//  AddNewBook.swift
//  ReadingInPixels
//
//  Created by Наталья Жерлова on 12.03.2024.
//

import SwiftUI

struct AddNewBook: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Literary Fiction"
    let genres = ["Literary Fiction", "Historical Fiction", "Science Fiction", "Speculative Fiction", "Fantasy", "Dystopian Fiction", "Thriller", "Horror", "Romance", "Non-fiction", "Memoir", "Poetry", "Essays"]
    @State private var rating = 3
    @State private var format = "Physical Book"
    let formats = ["Physical Book", "E-book", "Audiobook"]
    @State private var gender = "Female"
    let genders = ["Female", "Male", "Other"]
    @State private var language = "English"
    let languages = ["English", "Russian", "East Asian", "East European", "Iberian", "West European", "West Asian"]
    @State private var year = "2024"
    @State private var selectionDate = Date.now
    @State private var pageCount = 0
    @FocusState private var titleIsFocused: Bool
    @FocusState private var authorIsFocused: Bool
    @FocusState private var pageCountIsFocused: Bool

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                        .focused($titleIsFocused)
                } header: {
                    Text("title")
                        .foregroundColor(pink)
                }
                
                Section {
                    TextField("Author", text: $author)
                        .focused($authorIsFocused)
                } header: {
                    Text("author")
                        .foregroundColor(pink)
                }
                
                Section {
                    Picker("Genre of the book", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("genre")
                        .foregroundColor(pink)
                }
                
                Section {
                    HStack {
                        RatingView(rating: $rating)
                    }
                    .buttonStyle(.plain)
                } header: {
                    Text("how did you rate this book?")
                        .foregroundColor(pink)
                }
                
                Section {
                    Picker("Format of the book", selection: $format) {
                        ForEach(formats, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("what format did you read it in?")
                        .foregroundColor(pink)
                }
                
                Section {
                    Picker("Gender of the author", selection: $gender) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("is the author male of female?")
                        .foregroundColor(pink)
                }
                
                Section {
                    Picker("Language of the book", selection: $language) {
                        ForEach(languages, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("what is the original language of the book?")
                        .foregroundColor(pink)
                }
                
                Section {
                    DatePicker(selection: $selectionDate, in: ...Date.now, displayedComponents: .date) {
                        Text("Publication date")
                    }
                } header: {
                    Text("what was the publication date of this book?")
                        .foregroundColor(pink)
                }
                
                Section {
                    TextField("Page count", value: $pageCount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($pageCountIsFocused)
                } header: {
                    Text("how many pages does the book have?")
                        .foregroundColor(pink)
                }
            
                Section {
                    Button("Save") {
                        let newBook = BookCreateParams(title: title, author: author, genre: genre, rating: rating, format: format, gender: gender, language: language, year: selectionDate.formatted(date: .long, time: .omitted), page: pageCount)
                        Task {
                            do {
                                try await bookCreateHTTP(input: newBook)
                            } catch {
                                print("error")
                            }
                        }
                        dismiss()
                    }
                }
                .foregroundColor(pink)
            }
            .navigationBarTitle("New Book", displayMode: .inline)
            .toolbar {
                if titleIsFocused {
                    Button("Done") {
                        titleIsFocused = false
                    }
                }
                
                if authorIsFocused {
                    Button("Done") {
                        authorIsFocused = false
                    }
                }
                
                if pageCountIsFocused {
                    Button("Done") {
                        pageCountIsFocused = false
                    }
                }
            }
            
//            .toolbar {
//                ToolbarItemGroup(placement: .keyboard) {
//                    Spacer()
//                    Button("Done") {
//                        
//                    }
//                }
//            }
        }
    }
}

#Preview {
    AddNewBook()
}
