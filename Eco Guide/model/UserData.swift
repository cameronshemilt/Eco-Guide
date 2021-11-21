import Combine
import SwiftUI
import CoreData

struct Defaults {
    static let household = "peopleInHousehold"
    static let trash = "trashBagsPerWeek"
    static let driving = "kilometersPerWeek"
    static let diet = "diet"
    static let goalEmission = "goalEmission"
    static let didFinishOnboarding = "didFinishOnboarding"
}

enum Diet: String, CaseIterable {
    case vegan, vegetarian, pescatarian, littleMeat, dailyMeat
    
    var usageLabel: String {
        switch self {
        case .vegan:
            return "Vegan"
        case .vegetarian:
            return "Vegetarian"
        case .pescatarian:
            return "Pescatarian"
        case .littleMeat:
            return "Some meat"
        case .dailyMeat:
            return "Daily meat"
        }
    }
    
    var onboardingLabel: String {
        switch self {
        case .vegan:
            return "Vegan"
        case .vegetarian:
            return "Vegetarian"
        case .pescatarian:
            return "Pescatarian"
        case .littleMeat:
            return "Some meat now and then"
        case .dailyMeat:
            return "Daily meat consumption"
        }
    }
}

enum CarDistance: String, CaseIterable {
    case aboutZero, underTen, tenToThirty, thirtyToHundred, overHundred
    
    var usageLabel: String {
        return self.onboardingLabel
    }
    
    var onboardingLabel: String {
        switch self {
        case .aboutZero:
            return "about zero"
        case .underTen:
            return "5-10 km/day"
        case .tenToThirty:
            return "10-30 km/day"
        case .thirtyToHundred:
            return "30-100 km/day"
        case .overHundred:
            return "over 100 km/day"
        }
    }
    
    var number: Double {
        switch self {
        case .aboutZero:
            return 0.2
        case .underTen:
            return 8
        case .tenToThirty:
            return 20
        case .thirtyToHundred:
            return 70
        case .overHundred:
            return 140
        }
    }
}

enum Household: String, CaseIterable {
    case one, two, three, four, fiveOrMore
    
    var usageLabel: String {
        switch self {
        case .one:
            return "For me"
        case .two:
            return "For 2 people"
        case .three:
            return "For 3 people"
        case .four:
            return "For 4 people"
        case .fiveOrMore:
            return "For 5 or more people"
        }
    }
    
    var onboardingLabel: String {
        switch self {
        case .one:
            return "just me"
        case .two:
            return "one other"
        case .three:
            return "two more"
        case .four:
            return "three more"
        case .fiveOrMore:
            return "four or more"
        }
    }
    
    var numOfPeople: Int {
        switch self {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .fiveOrMore:
            return 5
        }
    }
}

enum Trash: String, CaseIterable {
    case lessThanOne, one, two, three, fourOrMore
    
    var usageLabel: String {
        switch self {
        case .lessThanOne:
            return "Less than one bag per week"
        case .one:
            return "One bag per week"
        case .two:
            return "2 bags per week"
        case .three:
            return "3 bags per week"
        case .fourOrMore:
            return "4+ bags per week"
        }
    }
    
    var onboardingLabel: String {
        switch self {
        case .lessThanOne:
            return "less than one"
        case .one:
            return "about one"
        case .two:
            return "two"
        case .three:
            return "three"
        case .fourOrMore:
            return "four or more"
        }
    }
    
    var num: Double {
        switch self {
        case .lessThanOne:
            return 0.5
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .fourOrMore:
            return 5
        }
    }
}

class EcoCalculator: ObservableObject {
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
    
    func netEmission(usageData: FetchedResults<UsageEntry>, tipData: FetchedResults<AcceptedTipEntry>) -> Double {
        return sumEmission(usageData: usageData) + sumSavings(tipData: tipData)
    }
    
    func sumEmission(usageData: FetchedResults<UsageEntry>) -> Double {
        var result = carEmission + electricityEmission + foodEmission + wasteEmission + waterEmission + heatingEmission
        result += usageData.reduce(0, { $0 + $1.co2 })
        return result
    }
    
    func sumSavings(tipData: FetchedResults<AcceptedTipEntry>) -> Double {
        return TipManager().data.reduce(0, { (sum, new) in
            if tipData.contains(where: { $0.id == new.id }) {
                return sum + new.callback()
            }
            return sum
        })
    }
    
    // MARK: Calc Emissions with UserDefaults
    var carEmission: Double {
        return EcoCalculator.carEmission(km: Double(driving.number), isElectric: false)  * 365
    }
    var electricityEmission: Double {
        return EcoCalculator.heating(people: household.numOfPeople, renewable: false)
    }
    var foodEmission: Double {
        switch diet {
        case .vegan:
            return 6.4 * 365
        case .vegetarian:
            return 8.4 * 365
        case .pescatarian:
            return 8.6 * 365
        case .littleMeat:
            return 11 * 365
        case .dailyMeat:
            return 15.8 * 365
        }
    }
    var wasteEmission: Double {
        return EcoCalculator.trash(kg: 457) * trash.num
    }
    var waterEmission: Double {
        return 0.00035 * 147 * 365 * Double(household.numOfPeople)
    }
    var heatingEmission: Double {
#warning("TODO")
        return 888
    }
    
    // MARK: Static Funcs
    static func carEmission(km: Double, isElectric: Bool) -> Double {
        if isElectric {
            return 0.05 * km
        }
        return 0.15 * km
    }
    static func trash(kg: Double) -> Double {
        return 0.5 * kg
    }
    static func plastic(bottles: Double) -> Double {
        return 0.12 * bottles
    }
    static func paper(kg: Double) -> Double {
        return 0.2 * kg
    }
    static func plane(h: Double) -> Double {
        return 90 * h
    }
    static func meat(kg: Double) -> Double {
        return 99 * kg
    }
    static func heating(people: Int, renewable: Bool) -> Double {
        let factor = renewable ? 0.25 : 0.35
        switch people {
        case 1:
            return factor * 1600
        case 2:
            return factor * 2300
        case 3:
            return factor * 2800
        case 4:
            return factor * 3200
        default:
            return factor * 3500
        }
    }
    static func food(diet: Diet, days: Int) -> Double {
        switch diet {
        case .vegan:
            return 6.4 * Double(days)
        case .vegetarian:
            return 8.4 * Double(days)
        case .pescatarian:
            return 8.6 * Double(days)
        case .littleMeat:
            return 11 * Double(days)
        case .dailyMeat:
            return 15.8 * Double(days)
        }
    }
    static func tapWater(litres: Double) -> Double {
        return 0.00035 * litres
    }
}
