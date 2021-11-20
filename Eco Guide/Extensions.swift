//
//  Extensions.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

struct Defaults {
    static let household = "peopleInHousehold"
    static let trash = "trashBasgPerWeek"
    static let driving = "kilometersPerWeek"
    static let electicCar = "ownsElectricCar"
    static let diet = "diet"
}

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

