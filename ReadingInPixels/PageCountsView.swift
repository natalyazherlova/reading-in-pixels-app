//
//  PageCountsView.swift
//  ReadingInPixels
//
//  Created by Наталья Жерлова on 05.04.2024.
//

import SwiftUI

struct PageCountsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var books: [BookItem] = []
    @State private var showingBookDetails = false
    let pageCounts = ["1 - 100", "101 - 300", "301 - 500", "501 - 700", "701 - 900", "901+"]
    
    func defineRange(_ n: Int) -> String {
        switch n {
        case 1...100: return pageCounts[0]
        case 101...300: return pageCounts[1]
        case 301...500: return pageCounts[2]
        case 501...700: return pageCounts[3]
        case 701...900: return pageCounts[4]
        default: return pageCounts[5]
        }
    }
    
    let dict: [String: Color] = ["1 - 100": pastelOrange, "101 - 300": pastelGreen, "301 - 500": pastelBlue, "501 - 700": pastelIndigo, "701 - 900": pastelPurple, "901+": pastelPink]
    
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
    
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(pink)
                .ignoresSafeArea()
            VStack {
                VStack (alignment: .leading) {
                    ForEach (pageCounts, id: \.self) { pageCount in
                        HStack {
                            Rectangle()
                                .border(.black)
                                .frame(width: 15, height: 15)
                                .foregroundColor(dict[pageCount])
                                .padding(.horizontal, 3)
                            Text(pageCount)
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
                                        .foregroundColor(dict[defineRange(books[item-1].page)])
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
        PageCountsView()
    }
}
