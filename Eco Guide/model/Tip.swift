//
//  Tip.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 20.11.21.
//

import Foundation
import SwiftUI

struct Tip: Identifiable {
    let id: Int
    let title: String
    let description: String
    let category: Categories
    let callback: () -> Double
}

class TipManager: ObservableObject {
    @AppStorage(Defaults.household) private var household: Household = .one {
        willSet {
            // Call objectWillChange manually since @AppStorage is not published
            objectWillChange.send()
        }
    }
    @AppStorage(Defaults.trash) private var trash: Trash = .one {
        willSet {
            objectWillChange.send()
        }
    }
    @AppStorage(Defaults.driving) private var driving: CarDistance = .underTen {
        willSet {
            objectWillChange.send()
        }
    }
    @AppStorage(Defaults.diet) private var diet: Diet = .dailyMeat {
        willSet {
            objectWillChange.send()
        }
    }
    
    var data: [Tip] {
        return [
            Tip(id: 1, title: "Using renewable energy",
                description: "By using renewable energy, you ensure the electricity you use at home is not sourced by burning coal or atomic power.",
                category: .housing,
                callback: { return (EcoCalculator.heating(people: self.household.numOfPeople, renewable: false) - EcoCalculator.heating(people: self.household.numOfPeople, renewable: true)) * -1 }),
            Tip(id: 2, title: "Take shorter showers",
                description: "Try reducing your shower time by 5 minutes. This will make a higher difference than you might think.",
                category: .living,
                callback: { EcoCalculator.tapWater(litres: 50)*365 }), // 10l per minute
            Tip(id: 3, title: "Change to an electric car",
                description: "On average, electric vehicles produce over 60% less carbon emissions, that gas cars.",
                category: .transport,
                callback: { return -1*(EcoCalculator.carEmission(km: self.driving.number, isElectric: false) - EcoCalculator.carEmission(km: self.driving.number, isElectric: true)) }),
            Tip(id: 4, title: "Use local produce",
                description: "When buying local produce, your food does not have to travel over the Atlantic by ship and drive far distances in a diesel truck.",
                category: .nutrition,
                callback: { return -137 }),
            Tip(id: 5, title: "Use seasonal food",
                description: "Using seasonal food, ensures your food is not flown in from another country with a warmer climate.",
                category: .nutrition,
                callback: { return -119 }),
            Tip(id: 6, title: "Try eating less meat",
                description: "A vegan diet can so much as half your carbon footprint in perspective of nutrition.",
                category: .nutrition,
                callback: { return -1*(365*15.8 - 365*6.4) }),
            Tip(id: 7, title: "Buy only what you eat",
                description: "by only buying what you will consume, you don't throw away food that used resources in production.",
                category: .wasteReduction,
                callback: { return -183 }),
            Tip(id: 8, title: "Buy responsible manufactured clothes",
                description: "For example from recycled materials or brands with eco-labels.",
                category: .living,
                callback: { return -84 }),
            Tip(id: 9, title: "Consider buying second hand",
                description: "Not everything has to be brand new. Only because somebody is selling his stuff, doesn't mean it's broken.",
                category: .living,
                callback: { return -179 }),
            Tip(id: 10, title: "Use public transportation",
                description: "Consider using public transportation to work. Not only does it help the climate, it also gives you time to relax.",
                category: .transport,
                callback: { return (EcoCalculator.carEmission(km: self.driving.number, isElectric: false) * -0.95) }),
            Tip(id: 11, title: "Avoid short distance flights",
                description: "Short distance flights from one close city to another can be perfectly substituted by train.",
                category: .transport,
                callback: { return (EcoCalculator.plane(h: 1.5) * -5) }), // avg. 5 short distance flights per year
            Tip(id: 12, title: "Turn off heating in summer",
                description: "Why keep the radiator on, when it's 28 degrees outside. Let the sun do the heating",
                category: .housing,
                callback: { return (EcoCalculator.heating(people: self.household.numOfPeople, renewable: false) * -167) }),
            Tip(id: 13, title: "Turn off the tap",
                description: "Turn off your water tap while brushing your teeth or doing the dishes.",
                category: .living,
                callback: { return (EcoCalculator.tapWater(litres: 10)*365) }),
            Tip(id: 14, title: "Pull the plug when not in use",
                description: "When you aren't using your coffee machine or mixer, consider pulling its plug to save energy.",
                category: .other,
                callback: { return -86 }),
            Tip(id: 15, title: "Buy efficient appliances",
                description: "When looking for a new fridge, washing machine or vacuums cleaner, look out for the EU-energy-label.",
                category: .housing,
                callback: { return -600 }),
            Tip(id: 16, title: "Shop with reusable bags",
                description: "Don't buy a plastic bag every time you go shopping in the supermarket. Bring your own.",
                category: .wasteReduction,
                callback: { return -206 }),
            Tip(id: 17, title: "Have your vacation nearby",
                description: "You don't have to fly to the other side of the planet to see beautiful places. Some sights are closer than you think.",
                category: .other,
                callback: { return (EcoCalculator.plane(h: 5) * -2) }),
        ]
    }
}
