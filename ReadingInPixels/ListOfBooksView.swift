//
//  ListOfBooksView.swift
//  ReadingInPixels
//
//  Created by Наталья Жерлова on 01.04.2024.
//
import SwiftUI

struct ListOfBooksView: View {
    @Environment(\.dismiss) var dismiss
    @State private var books: [BookItem] = []
    @State var isLoading: Bool = false
    
    var body: some View {
        List {
            ForEach(books) { book in
                NavigationLink {
                    DetailView(book: book)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                            Text(book.author)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .onDelete(perform: deleteBooks)
        }
        .task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                books = try await booksGetHTTP()
            } catch {
                print("error")
            }
        }
        .foregroundColor(pink)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
                    .foregroundColor(pink)
            }
        }
        .overlay {
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .background {
                        pink.opacity(0.05)
                    }
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            Task {
                try await bookDeleteHTTP(id: book.id)
                do {
                    books = try await booksGetHTTP()
                } catch {
                    print("error")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListOfBooksView()
    }
    
}
