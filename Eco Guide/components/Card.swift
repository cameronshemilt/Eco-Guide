//
//  Card.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

struct Card<Content: View>: View {
    let content: Content
    var alignment: HorizontalAlignment
    var spacing: CGFloat?
    var padding: CGFloat
    var color: Color
    var shadow: Bool

    init(alignment: HorizontalAlignment = .center,
         spacing: CGFloat? = nil,
         innerPadding: CGFloat = 17,
         color: Color = .white,
         shadow: Bool = true,
         @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.alignment = alignment
        self.spacing = spacing
        self.padding = innerPadding
        self.color = color
        self.shadow = shadow
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            content
        }
        .padding(padding)
        .background(
            RoundedRectangle(cornerRadius: 21)
                .foregroundColor(color)
        )
        .shadow(color: shadow ? .black.opacity(0.16) : .clear, radius: 6, x: 0, y: 3)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(shadow: true)  {
            Text("Content Within")
        }
        .frame(maxWidth: .infinity)
        .border(.red)
        .padding()
        .background(Color.backgroundColor)
    }
}
