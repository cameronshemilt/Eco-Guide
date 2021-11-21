//
//  FunFact.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 20.11.21.
//

import Foundation

struct FunFact: Identifiable {
    let id = UUID()
    let fact: String
    let category: Categories // transport, nutrition, wasteReduction, housing, living, other
}


extension FunFact {
    static let data: [FunFact] = [
        .init(fact: "According to sustainable facts about 80% of the items that Americans throw away can be recycled. However, currently, America’s recycling rate is at only 28%.", category: .wasteReduction),
        .init(fact: "The average American uses 650 pounds of paper each year. If all this paper was recycled, we could save up to 100 million tons of wood every year.", category: .wasteReduction),
        .init(fact: "Environmental sustainability facts show that enough plastic is thrown away each year to circle the earth four times.", category: .wasteReduction),
        .init(fact: "Americans use over 2.5 million plastic bottles every thirty minutes. Most of these bottles are simply thrown away even though they can be recycled.", category: .wasteReduction),
        .init(fact: "It takes a 15-year-old tree to produce 700 grocery bags.", category: .wasteReduction),
        .init(fact: "An average American family can use up to 984 litres of water at home per day.", category: .living),
        .init(fact: "It takes about 17 litres of water to brush your teeth if you leave your tap running.", category: .living),
        .init(fact: "A 15-minutes shower takes 25-50 gallons of water.", category: .living),
        .init(fact: "Sustainability fun facts have revealed that if just one person goes vegan, they can save approximately 830 000 litres of water a year.", category: .living),
        .init(fact: "When you leave your computer monitors on overnight they emit 8 million kilograms of carbon dioxide every year.", category: .other),
        .init(fact: "We need to reduce carbon dioxide emissions by humans to 45% from 2010 levels by 2030 and reach net-zero by 2050 to avoid a climate change catastrophe.", category: .other),
        .init(fact: "Improving fuel economy reduces one’s carbon footprint: Driving at the speed limit can improve fuel economy by 7 to 14 percent.", category: .transport),
        .init(fact: "If you take a long-haul flight, then you will be surprised by knowing that its CO2 equivalent is higher than what a single person in many countries causes in average per year.", category: .transport),
        .init(fact: "The production of one kilo of beef causes between 7 and 28 kilos of greenhouse gas emissions – compared to less than one kilogram of fruit or vegetables.", category: .nutrition),
        .init(fact: "Buildings emit 39 percent of the CO2 released in the U.S.", category: .housing)
    ]
}
