import Combine
import SwiftUI

struct Defaults {
    static let household = "peopleInHousehold"
    static let trash = "trashBasgPerWeek"
    static let driving = "kilometersPerWeek"
    static let carType = "carType"
    static let diet = "diet"
}

enum Diet: String {
    case vegan, vegetarian, pescetarian, littleMeat, dailyMeat
}

enum CarDistance: String {
    case underTen, tenToThirty, thirtyToHundred, overHundred
}

enum CarType: String {
    case gas, electric
}

enum Household: String {
    case one, two, three, four, fiveOrMore
}

enum Trash: String {
    case lessThanOne, one, two, three, fourOrMore
}

class EcoCalculator: ObservableObject {
    @AppStorage(Defaults.household) private var household: Household = .one {
        willSet {
            // Call objectWillChange manually since @AppStorage is not published
            objectWillChange.send()
        }
    }

    var sumEmission: Double {
        return 420
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
