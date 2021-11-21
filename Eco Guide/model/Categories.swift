//
//  Category.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 20.11.21.
//

import SFSafeSymbols

enum Categories: String, CaseIterable, Identifiable {
    var id: String {
        return rawValue
    }
    
    case transport, housing, nutrition, wasteReduction, living, other
    
    init(_ string: String) {
        self = Categories(rawValue: string) ?? .other
    }
    
    var images: [String] {
        switch self {
        case .living:
            return ["living-1", "living-2", "living-3", "living-4"]
        case .transport:
            return ["transport-1", "transport-2", "transport-3", "transport-4"]
        case .nutrition:
            return ["food-min", "food-1", "food-2", "food-3"]
        case .wasteReduction:
            return ["waste-1", "waste-2", "waste-3"]
        case .housing:
            return ["house-1", "house-2", "house-3", "house-4"]
        case .other:
            return ["bulb-min", "fairn-min", "forest-min", "lake-min", "plastic-min", "road-min"]
        }
    }
    
    var systemSymbol: SFSymbol {
        switch self {
        case .living:
            return .figureWalk
        case .transport:
            return .carFill
        case .nutrition:
            return .forkKnife
        case .wasteReduction:
            return .trashFill
        case .housing:
            return .houseFill
        case .other:
            return .ellipsis
        }
    }
    
    var name: String {
        switch self {
        case .living:
            return "Living"
        case .transport:
            return "Transport"
        case .nutrition:
            return "Nutrition"
        case .wasteReduction:
            return "Waste Reduction"
        case .housing:
            return "Housing"
        case .other:
            return "Other"
        }
    }
}
