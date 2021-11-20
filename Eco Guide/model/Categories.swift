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
    
    case transport, nutrition, wasteReduction, housing, living, other
    
    init(_ string: String) {
        self = Categories(rawValue: string) ?? .other
    }
    
    var images: [String] {
        return ["bulb-min", "food-min", "fairn-min", "forest-min", "lake-min", "plastic-min", "road-min"]
        #warning("todo categorize images")
        switch self {
        case .living:
            return []
        case .transport:
            return []
        case .nutrition:
            return []
        case .wasteReduction:
            return []
        case .housing:
            return []
        case .other:
            return []
        }
    }
    
    var systemSymbol: SFSymbol {
        switch self {
        case .living:
            return .houseFill
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
