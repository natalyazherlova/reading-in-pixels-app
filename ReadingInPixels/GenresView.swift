//
//  GenresView.swift
//  ReadingInPixels
//
//  Created by Наталья Жерлова on 26.03.2024.
//

import SwiftUI

struct GenresView: View {
    @State private var books: [BookItem] = []
    let genres = ["Literary Fiction", "Historical Fiction", "Science Fiction", "Speculative Fiction","Dystopian Fiction", "Fantasy", "Romance", "Thriller", "Horror", "Non-fiction", "Memoir", "Poetry", "Essays"]
    let dict: [String: Color] = ["Literary Fiction": pastelYellow, "Historical Fiction": pastelOrange, "Science Fiction": pastelDarkPurple, "Speculative Fiction": pastelPurple, "Fantasy": pastelBlue, "Dystopian Fiction": pastelIndigo, "Thriller": pastelRed, "Horror": pastelDarkRed, "Romance": pastelPink, "Non-fiction": pastelBrown, "Memoir": pastelTeal, "Poetry": pastelForestGreen, "Essays": pastelGreen]
    @State private var items  = Array(1...120)
    @State var isLoading: Bool = false
    
    let columns = [
        GridItem(.fixed(30), spacing: 3),
        GridItem(.fixed(30), spacing: 3),
        GridItem(.fixed(30), spacing: 3),
        GridItem(.fixed(30), spacing: 3),
        GridItem(.fixed(30), spacing: 3),
        GridItem(.fixed(30), spacing: 3),
        GridItem(.fixed(30), spacing: 3),
        GridItem(.fixed(30), spacing: 3),
        GridItem(.fixed(30), spacing: 3),
        GridItem(.fixed(30), spacing: 3)]
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(pink)
                .ignoresSafeArea()
            VStack {
                VStack (alignment: .leading) {
                    ForEach (genres, id: \.self) { genre in
                        HStack {
                            Rectangle()
                                .border(.black)
                                .frame(width: 15, height: 15)
                                .foregroundColor(dict[genre])
                                .padding(.horizontal, 3)
                            Text(genre)
                                .font(.footnote)
                            Spacer()
                        }
                    }
                }
                .padding(10)
                .background(Color.secondary)
                .cornerRadius(15)
                .padding(.horizontal, 100)
                .padding(10)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 3) {
                        ForEach(items, id: \.self) { item in
                            if (item <= books.count) {
                                NavigationLink {
                                    DetailView(book: books[item-1])
                                } label: {
                                    Rectangle()
                                        .border(.black)
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .foregroundColor(dict[books[item-1].genre])
                                }
                            } else {
                                Rectangle()
                                    .border(.black)
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(10)
                    .background(Color.secondary)
                    .cornerRadius(15)
                    .padding(.horizontal, 30)
                }
            }
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
        .overlay {
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .background {
                        pink.opacity(0.7)
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        GenresView()
    }
}
