//
//  ContentView.swift
//  ReadingInPixels
//
//  Created by Наталья Жерлова on 12.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddScreen = false
    @State private var showingListOfBooksScreen = false
    @State private var showingGenresScreen = false
    @State private var showingRatingsScreen = false
    @State private var showingPageCountsScreen = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Button {
                    showingAddScreen.toggle()
                } label: {
                    Text("Add new book")
                        .modifier(MainButton())
                }
                
                NavigationLink {
                    ListOfBooksView()
                } label: {
                    Text("All Books")
                        .modifier(MainButton())
                }
                
                Spacer()
                
                Section {
                    NavigationLink {
                        GenresView()
                    } label: {
                        Text("Genres in pixels")
                            .modifier(PixelsButton())
                    }
                    
                    NavigationLink {
                        RatingsView()
                    } label: {
                        Text("Ratings in pixels")
                            .modifier(PixelsButton())
                    }
                    
                    NavigationLink {
                        FormatsView()
                    } label: {
                        Text("Formats in pixels")
                            .modifier(PixelsButton())
                    }
                    
                    NavigationLink {
                        AuthorsView()
                    } label: {
                        Text("Authors in pixels")
                            .modifier(PixelsButton())
                    }
                    
                    NavigationLink {
                        LanguagesView()
                    } label: {
                        Text("Languages in pixels")
                            .modifier(PixelsButton())
                    }
                        
                    NavigationLink {
                        PubDatesView()
                    } label: {
                        Text("Publication dates in pixels")
                            .modifier(PixelsButton())
                    }
                    
                    NavigationLink {
                        PageCountsView()
                    } label: {
                        Text("Page count in pixels")
                            .modifier(PixelsButton())
                    }
                }
                
                Spacer()
                    
            }
            .padding()
            .sheet(isPresented: $showingAddScreen) {
                AddNewBook()
            }
        }
        .tint(.primary)
        
    }
}

#Preview {
    ContentView()
}
