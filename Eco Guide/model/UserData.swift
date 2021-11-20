import Combine
import SwiftUI

struct Defaults {
    static let household = "peopleInHousehold"
    static let trash = "trashBasgPerWeek"
    static let driving = "kilometersPerWeek"
    static let diet = "diet"
    static let goalEmission = "goalEmission"
}

enum Diet: String, CaseIterable {
    case vegan, vegetarian, pescetarian, littleMeat, dailyMeat
    
    var usageLabel: String {
        switch self {
        case .vegan:
            return "Vegan"
        case .vegetarian:
            return "Vegetarian"
        case .pescetarian:
            return "Pescetarian"
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
        case .pescetarian:
            return "Pescetarian"
        case .littleMeat:
            return "Some meat now and then"
        case .dailyMeat:
            return "Daily meat consumption"
        }
    }
}

enum CarDistance: String, CaseIterable {
    case underTen, tenToThirty, thirtyToHundred, overHundred
    
    var usageLabel: String {
        return self.onboardingLabel
    }
    
    var onboardingLabel: String {
        switch self {
        case .underTen:
            return "under 10 km"
        case .tenToThirty:
            return "10-30 km"
        case .thirtyToHundred:
            return "30-100 km"
        case .overHundred:
            return "over 100 km"
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
            // Call objectWillChange manually since @AppStorage is not published
            objectWillChange.send()
        }
    }
    @AppStorage(Defaults.driving) private var driving: CarDistance = .underTen {
        willSet {
            // Call objectWillChange manually since @AppStorage is not published
            objectWillChange.send()
        }
    }
    @AppStorage(Defaults.diet) private var diet: Diet = .dailyMeat {
        willSet {
            // Call objectWillChange manually since @AppStorage is not published
            objectWillChange.send()
        }
    }
    
    var netEmission: Double {
        return 4200
    }

    var sumEmission: Double {
        return 1800
    }

    // MARK: Calc Emissions with UserDefaults
    var carEmission: Double {
        return 42
    }
    var electricityEmission: Double {
        return 42
    }
    var foodEmission: Double {
        return 42
    }
    var wasteEmission: Double {
        return 42
    }
    var waterEmission: Double {
        return 42
    }
    var heatingEmission: Double {
        return 42
    }

    // MARK: Static Funcs
    static func carEmission(km: Double, isElectric: Bool) -> Double {
        return 42
    }
    static func trash(litres: Double) -> Double {
        return 42
    }
    static func plastic(bottles: Double) -> Double {
        return 42
    }
    static func paper(grams: Double) -> Double {
        return 42
    }
    static func plane(km: Double) -> Double {
        return 42
    }
    static func meat(kg: Double) -> Double {
        return 42
    }
}
