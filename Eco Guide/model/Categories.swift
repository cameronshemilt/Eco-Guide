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
}
