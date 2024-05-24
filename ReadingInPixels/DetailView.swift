//
//  DetailView.swift
//  BookwormMain
//
//  Created by Наталья Жерлова on 28.03.2024.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    let book: BookItem
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(pink)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text(book.author)
                        .font(.title)
                        .foregroundStyle(pink)
                        .padding()
                    
                    Text("gender: \(book.gender)")
                        .font(.caption)
                        .foregroundStyle(pink)
                }
                .padding(10)
                .background(backgroundGrey)
                .cornerRadius(15)
                .padding(.horizontal, 10)
                .padding(10)
                
                RatingView(rating: .constant(book.rating))
                    .font(.largeTitle)
                    .padding(10)
                    .background(backgroundGrey)
                    .cornerRadius(15)
                    .padding(.horizontal, 10)
                    .padding(10)
                
                Text("GENRE: \(book.genre.uppercased())")
                    .padding(10)
                    .foregroundStyle(pink)
                    .background(backgroundGrey)
                    .cornerRadius(15)
                    .padding(.horizontal, 10)
                    .padding(10)
                
                VStack(alignment: .leading) {
                    Text("Format: \(book.format)")
                        .font(.title)
                        .foregroundStyle(pink)
                        .padding()
                    
                    Text("Original language: \(book.language)")
                        .font(.title)
                        .foregroundStyle(pink)
                        .padding()
                    
                    Text("Date published: \(book.year)")
                        .font(.title)
                        .foregroundStyle(pink)
                        .padding()
                    
                    Text("Page count: \(book.page)")
                        .font(.title)
                        .foregroundStyle(pink)
                        .padding()
                    
                }
                .padding(10)
                .background(backgroundGrey)
                .cornerRadius(15)
                .padding(.horizontal, 10)
                .padding(10)
                
            }
            .navigationTitle(book.title)
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            .alert("Delete book", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive, action: deleteBooks)
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure?")
            }
            .toolbar {
                Button("Delete this book", systemImage: "trash") {
                    showingDeleteAlert = true
                }
            }
        }
    }
    
    func deleteBooks() {
        Task {
            do {
                try await bookDeleteHTTP(id: book.id)
            } catch {
                print("error: \(error)")
            }
            await doDissmiss()
        }
    }
    
    @MainActor
    func doDissmiss() {
        dismiss()
    }
}

#Preview {
    NavigationStack {
        let example = BookItem(id: UUID(), title: "test book", author: "test author", genre: "sci-fi", rating: 5, format: "e-book", gender: "female", language: "english", year: "9 April 2024", page: 900)
        DetailView(book: example)
    }
}
