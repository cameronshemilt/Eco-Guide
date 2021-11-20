//
//  StoryPreview.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 20.11.21.
//

import SwiftUI
import SFSafeSymbols

struct StoryPreview: View {
    let category: Categories
    let seen: Bool
    var size: CGFloat
    
    var body: some View {
        Image(systemSymbol: category.systemSymbol)
            .resizable().scaledToFit()
            .foregroundColor(.white)
            .padding(size/4)
            .frame(width: size, height: size)
            .overlay(Circle().stroke(seen ? .gray : .green, lineWidth: 2))
            .background {
                Circle().fill(.green).padding(3)
            }
    }
}

struct StoryPreview_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(Categories.allCases, id: \.self) { cate in
                HStack {
                    StoryPreview(category: cate, seen: true, size: 50)
                    StoryPreview(category: cate, seen: false, size: 50)
                }
            }
        }
    }
}
