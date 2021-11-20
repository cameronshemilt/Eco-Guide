//
//  FilterTag.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 20.11.21.
//

import SwiftUI

struct FilterTag: View {
    let text: String
    let active: Bool
    let color: Color
    
    var body: some View {
        Text(text)
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            .background(color.opacity(active ? 1 : 0.25))
            .cornerRadius(.infinity)
    }
}

struct FilterTag_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 45) {
            HStack(spacing: 5) {
                FilterTag(text: "All", active: true, color: .green)
                FilterTag(text: "Living", active: false, color: .green)
                FilterTag(text: "Lifestyle", active: false, color: .green)
                FilterTag(text: "Transport", active: false, color: .green)
            }
            HStack(spacing: 5) {
                FilterTag(text: "All", active: true, color: .red)
                FilterTag(text: "Living", active: false, color: .red)
                FilterTag(text: "Lifestyle", active: false, color: .red)
                FilterTag(text: "Transport", active: false, color: .red)
            }
        }
    }
}
