//
//  OnboardingView.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 20.11.21.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var activeView: Int = 0
    
    var image: String {
        switch activeView {
        case 0:
            return "forest"
        case 1:
            return "food"
        case 2:
            return "road"
        case 3:
            return "road"
        case 4:
            return "bulb"
        case 5:
            return "plastic"
        default:
            return "forest"
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
            Button("Vegan", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("Vegetarian", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("Pescetarian", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("Some meat now and then", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("Daily meat consumption", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
    
    var carScreen: some View {
        VStack(spacing: 17) {
            Text("How much do you drive in one week ?")
                .font(.title)
            Spacer()
            Button("vegan", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("vegetarian", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("pescetarian", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("some meat now and then", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("daily meat consumption", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
    
    var carScreen2: some View {
        VStack(spacing: 17) {
            Text("Do you own an electric car ?")
                .font(.title)
            Spacer()
            Button("Yes", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("No", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
    
    var energyScreen: some View {
        VStack(spacing: 17) {
            Text("How many people live with you ?")
                .font(.title)
            Spacer()
            Button("just me", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("one other", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("two more", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("three more", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("four or more", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
    
    var trashScreen: some View {
        VStack(spacing: 17) {
            Text("How many bags of trash do you produce in a week ?")
                .font(.title)
            Spacer()
            Button("less than one", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("about one", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("two", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("three", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
            Button("four or more", action: { activeView += 1 })
                .buttonStyle(PrimaryButtonStyle(color: .white, foregroundColor: .primary))
        }
        .padding(.vertical, 30)
    }
    
    var summaryScreen: some View {
        VStack(spacing: 17) {
            Text("Based on our calculations, you produce about")
                .font(.title)
            Spacer()
            CarbonYearlyTitleView(value: 8739)
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
