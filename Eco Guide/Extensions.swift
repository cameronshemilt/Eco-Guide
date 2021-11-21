//
//  Extensions.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

extension Color {
    static var backgroundColor: Color {
        Color("backgroundColor")
    }
    static var redBackgroundColor: Color {
        Color("redBackgroundColor")
    }
}

struct TagButtonStyle: ButtonStyle {
    var active: Bool
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            .background(color.opacity(active ? 1 : 0.25).opacity(configuration.isPressed ? 0.8 : 1))
            .cornerRadius(.infinity)
    }
}

extension Double {
    var formattedUnitText: String {
        if self >= 0 {
            return "+\(Int(self))"
        }
        return "\(Int(self))"
    }
}

extension Binding where Value == Bool {
    var not: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}
