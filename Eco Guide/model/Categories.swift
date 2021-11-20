//
//  Category.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 20.11.21.
//

enum Categories: String, CaseIterable {
    case living, transport, other
    
    init(_ string: String) {
        switch string {
        case "living":
            self = .living
        case "transport":
            self = .transport
        default:
            self = .other
        }
    }
    
    var images: [String] {
        return ["bulb-min", "food-min", "fairn-min", "forest-min", "lake-min", "plastic-min", "road-min"]
        #warning("todo categorize images")
        switch self {
        case .living:
            return []
        case .transport:
            return []
        case .other:
            return []
        }
    }
    
    var name: String {
        switch self {
        case .living:
            return "Living"
        case .transport:
            return "Transport"
        case .other:
            return "Other"
        }
    }
}
