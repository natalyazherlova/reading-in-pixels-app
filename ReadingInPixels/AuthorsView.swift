//
//  AuthorsView.swift
//  ReadingInPixels
//
//  Created by Наталья Жерлова on 10.04.2024.
//

import SwiftUI

struct AuthorsView: View {
    @State private var books: [BookItem] = []
    let genders = ["Female", "Male", "Other"]
    let dict: [String: Color] = ["Other": pastelDarkPurple, "Female": pastelPink, "Male": pastelIndigo]
    @State private var items  = Array(1...120)
    
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
                    ForEach (genders, id: \.self) { gender in
                        HStack {
                            Rectangle()
                                .border(.black)
                                .frame(width: 15, height: 15)
                                .foregroundColor(dict[gender])
                                .padding(.horizontal, 3)
                            Text(gender)
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
                                        .foregroundColor(dict[books[item-1].gender])
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
        AuthorsView()
    }
}
