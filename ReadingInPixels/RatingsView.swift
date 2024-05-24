//
//  RatingsView.swift
//  ReadingInPixels
//
//  Created by Наталья Жерлова on 29.03.2024.
//

import SwiftUI

struct RatingsView: View {
    @State private var books: [BookItem] = []
    let ratings = [5, 4, 3, 2, 1]
    let dict: [Int: Color] = [1: pastelTeal, 2: pastelBlue, 3: pastelIndigo, 4: pastelPurple, 5: pastelPink]
    @State private var items = Array(1...120)
    
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
                VStack (alignment: .center) {
                    ForEach (ratings, id: \.self) { rating in
                        HStack {
                            Rectangle()
                                .border(.black)
                                .frame(width: 15, height: 15)
                                .foregroundColor(dict[rating])
                                .padding(.horizontal, 3)
                            RatingView(rating: .constant(rating))
                        }
                    }
                }
                .padding(10)
                .background(Color.secondary)
                .cornerRadius(15)
                .padding(10)
//                .padding(.horizontal, 30)

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
                                        .foregroundColor(dict[books[item-1].rating])
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
            do {
                books = try await booksGetHTTP()
            } catch {
                print("error")
            }
        }
    }
}

#Preview {
    NavigationStack {
        RatingsView()
    }
}
