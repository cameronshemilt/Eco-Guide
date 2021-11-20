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
    @AppStorage(Defaults.household) private var household: Household = .one
    @AppStorage(Defaults.trash) private var trash: Trash = .one
    @AppStorage(Defaults.goalEmission) private var goalEmission: Double = 10000
    @ObservedObject private var ecoCalculator = EcoCalculator()
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
                energyScreen
            case 4:
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
            ForEach(Diet.allCases, id: \.self) { type in
                Button(type.onboardingLabel, action: { diet = type; activeView += 1 })
                    .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            }
        }
        .padding(.vertical, 30)
    }
    
    var carScreen: some View {
        VStack(spacing: 17) {
            Text("How much do you drive in one week ?")
                .font(.title)
            Spacer()
            ForEach(CarDistance.allCases, id: \.self) { type in
                Button(type.onboardingLabel, action: { driving = type; activeView += 1 })
                    .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            }
        }
        .padding(.vertical, 30)
    }
    
    var energyScreen: some View {
        VStack(spacing: 17) {
            Text("How many people live with you ?")
                .font(.title)
            Spacer()
            ForEach(Household.allCases, id: \.self) { type in
                Button(type.onboardingLabel, action: { household = type; activeView += 1 })
                    .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            }
        }
        .padding(.vertical, 30)
    }
    
    var trashScreen: some View {
        VStack(spacing: 17) {
            Text("How many bags of trash do you produce in a week ?")
                .font(.title)
            Spacer()
            ForEach(Trash.allCases, id: \.self) { type in
                Button(type.onboardingLabel, action: { trash = type; activeView += 1 })
                    .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            }
        }
        .padding(.vertical, 30)
    }
    
    var summaryScreen: some View {
        VStack(spacing: 17) {
            Text("Based on our calculations, you produce about")
                .font(.title)
            Spacer()
            Card {
                CarbonYearlyTitleView(value: ecoCalculator.netEmission, title: "")
                    .foregroundColor(.red)
            }
            Spacer()
            Text("We’ll help you get that number down.")
                .font(.title)
            Spacer()
            Text("Let's define a goal:")
                .font(.title)

            LazyVGrid(columns: Array(repeating: .init(), count: 2)) {
                Button("-10%", action: {
                    goalEmission = 0.9 * ecoCalculator.netEmission
                    dismiss()
                }).buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
                Button("-15%", action: {
                    goalEmission = 0.85 * ecoCalculator.netEmission
                    dismiss()
                }).buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
                Button("-20%", action: {
                    goalEmission = 0.8 * ecoCalculator.netEmission
                    dismiss()
                }).buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
                Button("-25%", action: {
                    goalEmission = 0.75 * ecoCalculator.netEmission
                    dismiss()
                }).buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            }
        }
        .padding(.vertical, 30)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
