//
//  Tip.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 20.11.21.
//

import Foundation

struct Tip: Identifiable {
    let id: Int
    let title: String
    let description: String
    let category: Categories
    let calback: () -> Double
}

extension Tip {
    static let data = [
        Tip(id: 1, title: "Using renewable energy",
            description: "Lorem ipsum dolor sit met et circensum, vite cum lautet amica Quintus circus et domicil marcus Aurelius familia.",
            category: .living,
            calback: { return -539 }),
        Tip(id: 2, title: "Take shorter showers",
            description: "Lorem ipsum dolor sit met et circensum, vite cum lautet amica Quintus circus et domicil marcus Aurelius familia.",
            category: .living,
            calback: { return -829 }),
        Tip(id: 3, title: "Change to an electric car",
            description: "Lorem ipsum dolor sit met et circensum, vite cum lautet amica Quintus circus et domicil marcus Aurelius familia.",
            category: .transport,
            calback: { return -183 }),
    ]
}
