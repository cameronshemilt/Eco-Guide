//
//  OnboardingView.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 20.11.21.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage(Defaults.diet) private var diet: Diet = .vegan
    @AppStorage(Defaults.driving) private var driving: CarDistance = .tenToThirty
    @AppStorage(Defaults.carType) private var car: CarType = .gas
    @AppStorage(Defaults.household) private var household: Household = .one
    @AppStorage(Defaults.trash) private var trash: Trash = .one
    @State private var activeView: Int = 0
    
    var image: String {
        switch activeView {
        case 0:
            return "forest-min"
        case 1:
            return "food-min"
        case 2:
            return "road-min"
        case 3:
            return "road-min"
        case 4:
            return "bulb-min"
        case 5:
            return "plastic-min"
        default:
            return "forest-min"
        }
    }
    
    var body: some View {
        VStack {
            switch activeView {
            case 0:
                welcomeScreen
            case 1:
                dietScreen
            case 2:
                carScreen
            case 3:
                carScreen2
            case 4:
                energyScreen
            case 5:
                trashScreen
            default:
                summaryScreen
            }
        }
        .shadow(radius: 15)
        .padding(.horizontal, 30)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background {
            Image(image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            Color.black
                .ignoresSafeArea()
                .opacity(0.3)
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.white)
    }
    
    var welcomeScreen: some View {
        VStack {
            Text("Welcome")
                .font(.system(size: 55, weight: .semibold, design: .rounded))
            Spacer()
            Button("Start", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
    
    var dietScreen: some View {
        VStack(spacing: 17) {
            Text("How do you eat ?")
                .font(.title)
            Spacer()
            Button("Vegan", action: { diet = .vegan; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("Vegetarian", action: { diet = .vegetarian; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("Pescetarian", action: { diet = .pescetarian; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("Some meat now and then", action: { diet = .littleMeat; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("Daily meat consumption", action: { diet = .dailyMeat; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
    
    var carScreen: some View {
        VStack(spacing: 17) {
            Text("How much do you drive in one week ?")
                .font(.title)
            Spacer()
            Button("under 10 km", action: { driving = .underTen; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("10-30 km", action: { driving = .tenToThirty; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("30-100 km", action: { driving = .thirtyToHundred; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("over 100 km", action: { driving = .overHundred; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
    
    var carScreen2: some View {
        VStack(spacing: 17) {
            Text("Do you own an electric car ?")
                .font(.title)
            Spacer()
            Button("Yes", action: { car = .electric; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("No", action: { car = .gas; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
    
    var energyScreen: some View {
        VStack(spacing: 17) {
            Text("How many people live with you ?")
                .font(.title)
            Spacer()
            Button("just me", action: { household = .one; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("one other", action: { household = .two; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("two more", action: { household = .three; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("three more", action: { household = .four; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("four or more", action: { household = .fiveOrMore; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
    
    var trashScreen: some View {
        VStack(spacing: 17) {
            Text("How many bags of trash do you produce in a week ?")
                .font(.title)
            Spacer()
            Button("less than one", action: { trash = .lessThanOne; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("about one", action: { trash = .one; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("two", action: { trash = .two; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("three", action: { trash = .three; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("four or more", action: { trash = .fourOrMore; activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
    
    var summaryScreen: some View {
        VStack(spacing: 17) {
            Text("Based on our calculations, you produce about")
                .font(.title)
            Spacer()
            CarbonYearlyTitleView(value: 8739, title: "")
                .foregroundColor(.red)
            Spacer()
            Text("We’ll help you get that number down.")
                .font(.title)
            Spacer()
            Button("Get Started", action: { dismiss() })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
