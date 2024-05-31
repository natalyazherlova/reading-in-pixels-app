//
//  PubDatesView.swift
//  ReadingInPixels
//
//  Created by Наталья Жерлова on 09.04.2024.
//

import SwiftUI

struct PubDatesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var books: [BookItem] = []
    let years = ["2024", "2020 - 2023", "2010 - 2019", "2000 - 2009", "1980 - 1999", "1950 - 1979", "1930 - 1949", "1900 - 1929", "<1900"]
    
    func defineRange(_ n: String) -> String {
        let lastFourDigits = Int(n.suffix(4))!
        switch lastFourDigits {
        case 2024: return years[0]
        case 2020...2023: return years[1]
        case 2010...2019: return years[2]
        case 2000...2009: return years[3]
        case 1980...1999: return years[4]
        case 1950...1979: return years[5]
        case 1930...1949: return years[6]
        case 1900...1929: return years[7]
        default: return years[8]
        }
    }
    
    let dict: [String: Color] = ["2024": pastelPink, "2020 - 2023": pastelPurple, "2010 - 2019": pastelIndigo, "2000 - 2009": pastelBlue, "1980 - 1999": pastelTeal, "1950 - 1979": pastelForestGreen, "1930 - 1949": pastelGreen, "1900 - 1929": pastelOrange, "<1900": pastelBrown]
    
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
                    ForEach (years, id: \.self) { year in
                        HStack {
                            Rectangle()
                                .border(.black)
                                .frame(width: 15, height: 15)
                                .foregroundColor(dict[year])
                                .padding(.horizontal, 3)
                            Text(year)
                        }
                    }
                }
                .padding(10)
                .background(Color.secondary)
                .cornerRadius(15)
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
                                        .foregroundColor(dict[defineRange(books[item-1].year)])
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
        PubDatesView()
    }
}
