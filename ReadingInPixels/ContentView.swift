//
//  ContentView.swift
//  ReadingInPixels
//
//  Created by Наталья Жерлова on 12.03.2024.
//

import SwiftUI

let pink = Color(red: 0.63, green: 0.45, blue: 0.58)
let backgroundGrey = Color(red: 0.9255, green: 0.8431, blue: 0.9373)
let pastelPurple = Color(red: 0.6627, green: 0.5333, blue: 0.9373)
let pastelPink = Color(red: 0.9176, green: 0.5686, blue: 0.8314)
let pastelBlue = Color(red: 0.5569, green: 0.7529, blue: 0.9765)
let pastelYellow = Color(red: 0.949, green: 0.9451, blue: 0.7098)
let pastelOrange = Color(red: 0.9569, green: 0.7176, blue: 0.5451)
let pastelDarkRed = Color(red: 0.7098, green: 0.3882, blue: 0.4588)
let pastelDarkPurple = Color(red: 0.5569, green: 0.4039, blue: 0.698)
let pastelRed = Color(red: 0.949, green: 0.5412, blue: 0.5412)
let pastelGreen = Color(red: 0.6314, green: 0.8392, blue: 0.5255)
let pastelTeal = Color(red: 0.6078, green: 0.9686, blue: 0.8667)
let pastelBrown = Color(red: 0.5294, green: 0.3176, blue: 0.2902)
let pastelForestGreen = Color(red: 0.4627, green: 0.7373, blue: 0.6275)
let pastelIndigo = Color(red: 0.498, green: 0.5059, blue: 0.8784)

struct ColorPinkBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(pink)
    }
}

struct ColorPinkForeground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(pink)
    }
}

struct PixelsButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: 40)
            .modifier(ColorPinkForeground())
            .background(.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(pink, lineWidth: 4))
    }
}

struct MainButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: 60)
            .foregroundColor(.white)
            .modifier(ColorPinkBackground())
            .cornerRadius(15)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
    }
}

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
