//
//  HomeView.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

struct HomeView: View {
    @AppStorage(Defaults.goalEmission) private var goalEmission: Double = 10000
    @ObservedObject private var ecoCalculator = EcoCalculator()

    var body: some View {
        ScrollView {
            Group {
                // Title
                CarbonYearlyTitleView(value: ecoCalculator.netEmission, title: "Total Footprint")
                    .foregroundColor(ecoCalculator.netEmission <= goalEmission ? (ecoCalculator.netEmission <= 0 ? .green : .orange) : .red)
                    .padding(.vertical, 25)

                goalCard
                
                // Story Section
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(Categories.allCases, id: \.self) { category in
                            StoryPreview(category: category, seen: false, size: 50)
                                .padding(5)
                        }
                    }
                }
                .padding(.vertical)
                
                // chart section
                #warning("todo: chart section")
            }
            .padding(.horizontal)
        }
//        .fullScreenCover(isPresented: $story) {
//            QuickTips(tips: Tip.mockTips)
//        }
    }
    
    @State private var extendGoal = false
    var goalCard: some View {
        Card(innerPadding: 0, shadow: false) {
            Card {
                if ecoCalculator.netEmission < goalEmission {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("You reached your goal!")
                                .font(.title3)
                                .bold()
                            Text("Now let's see if you can further minimize your carbon footprint.")
                                .foregroundColor(.secondary)
                        }
                        .padding(.trailing)
                        Spacer(minLength: 0)
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Your Goal")
                                .font(.title3)
                                .bold()
                            Text("You have set yourself a goal of minimizing your carbon footprint.")
                                .foregroundColor(.secondary)
                        }
                        .padding(.trailing)
                        Spacer(minLength: 0)
                        
                        ProgressRing(1 - ((ecoCalculator.netEmission - goalEmission) / ecoCalculator.netEmission), color: .green)
                            .diameter(80)
                            .padding(5)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .onTapGesture {
                withAnimation {
                    extendGoal.toggle()
                }
            }
            if extendGoal {
                LazyVGrid(columns: Array(repeating: .init(), count: 2)) {
                    Button("-10%", action: { adaptGoal(0.9) })
                        .buttonStyle(PrimaryButtonStyle(color: .black, foregroundColor: .white))
                    Button("-15%", action: { adaptGoal(0.85) })
                        .buttonStyle(PrimaryButtonStyle(color: .black, foregroundColor: .white))
                    Button("-20%", action: { adaptGoal(0.8) })
                        .buttonStyle(PrimaryButtonStyle(color: .black, foregroundColor: .white))
                    Button("-25%", action: { adaptGoal(0.75) })
                        .buttonStyle(PrimaryButtonStyle(color: .black, foregroundColor: .white))
                }
                .padding(10)
            }
        }
    }
    
    
    func adaptGoal(_ val: Double) {
        withAnimation {
            goalEmission = val * ecoCalculator.netEmission
            extendGoal = false
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HomeView()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.backgroundColor)
    }
}
