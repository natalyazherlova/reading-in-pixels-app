
import Foundation
import SwiftUI


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
