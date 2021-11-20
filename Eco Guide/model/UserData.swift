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
