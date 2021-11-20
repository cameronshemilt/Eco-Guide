//
//  EmissionCalcItem.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 20.11.21.
//

import SFSafeSymbols

struct EmissionCalcItem: Equatable {
    let symbol: SFSymbol
    let name: String
    let unit: String
    let placeholder: String
    let callback: (Double) -> Double
    
    static func == (lhs: EmissionCalcItem, rhs: EmissionCalcItem) -> Bool {
        lhs.name == rhs.name
    }
}

extension EmissionCalcItem {
    static let items: [EmissionCalcItem] = [
        .init(symbol: .carFill, name: "Car Trip", unit: "kM", placeholder: "Distance", callback: { distance in
            return EcoCalculator.carEmission(km: distance, isElectric: false)
        }),
        .init(symbol: .airplaneDeparture, name: "Flight", unit: "h", placeholder: "Duration", callback: { duration in
            return EcoCalculator.plane(h: duration)
        }),
        .init(symbol: .forkKnife, name: "Meat", unit: "kG", placeholder: "Weight", callback: { weight in
            return EcoCalculator.meat(kg: weight)
        }),
        .init(symbol: .tortoiseFill, name: "Plastic", unit: "Bottles", placeholder: "Amount", callback: { amount in
            return EcoCalculator.plastic(bottles: amount)
        }),
        .init(symbol: .trashFill, name: "Trash", unit: "Bags", placeholder: "Amount", callback: { amount in
            return EcoCalculator.trash(kg: 32 * amount)
        }),
        .init(symbol: .newspaperFill, name: "Paper", unit: "sheets", placeholder: "Aount", callback: { amount in
            return EcoCalculator.paper(kg: 0.005 * amount)
        }),
    ]
}
