//
//  HomeView.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(entity: AcceptedTipEntry.entity(), sortDescriptors: []) private var tipData: FetchedResults<AcceptedTipEntry>
    @FetchRequest(entity: UsageEntry.entity(), sortDescriptors: []) private var usageData: FetchedResults<UsageEntry>
    @AppStorage(Defaults.goalEmission) private var goalEmission: Double = 10000
    @ObservedObject private var ecoCalculator = EcoCalculator()

    @State private var showCategoryFacts: Categories? = nil
    
    var numberOfTrees: Int {
        return Int(floor(abs(ecoCalculator.sumSavings(tipData: tipData) / 21.7)))
    }
    
    var body: some View {
            ZStack {
                // forest section
                VStack {
                    Spacer()
                    EquatableView(content: Forest(count: numberOfTrees))
                        .offset(x: 0, y: 50)
                }

                VStack {
                    // Title
                    CarbonYearlyTitleView(value: ecoCalculator.netEmission(usageData: usageData, tipData: tipData), title: "Total Footprint")
                        .foregroundColor(ecoCalculator.netEmission(usageData: usageData, tipData: tipData) <= goalEmission ? (ecoCalculator.netEmission(usageData: usageData, tipData: tipData) <= 0 ? .green : .orange) : .red)
                        .padding(.vertical, 25)
                    
                    goalCard
                    
                    // Story Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(Categories.allCases, id: \.self) { category in
                                StoryPreview(category: category, seen: false, size: 50)
                                    .padding(5)
                                    .onTapGesture {
                                        showCategoryFacts = category
                                    }
                            }
                        }
                    }
                    .padding(.vertical)
                    Spacer().frame(maxHeight: 40)
                    
                    VStack(spacing: 5) {
                        Text("The amount of CO2 you are\n saving is equal to")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        VStack(spacing: 0) {
                            Text("\(numberOfTrees)")
                                .bold()
                                .font(.system(size: 45, weight: .bold, design: .rounded))
                                .foregroundColor(.green)
                            Text("TREES")
                                .bold()
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.green)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
        }
        .fullScreenCover(item: $showCategoryFacts) { cate in
            if let fact = FunFact.data.first(where: { $0.category == cate }) {
                QuickTips(facts: [fact] + Array(FunFact.data.filter({$0.id != fact.id}).shuffled().suffix(3)))
            } else {
                QuickTips(facts: Array(FunFact.data.shuffled().suffix(4)))
            }
        }
    }
    
    @State private var extendGoal = false
    var goalCard: some View {
        Card(innerPadding: 0, shadow: false) {
            Card {
                if ecoCalculator.netEmission(usageData: usageData, tipData: tipData) < goalEmission {
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
                        
                        ProgressRing(calculateProgress(), color: .green)
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
    
    func calculateProgress() -> CGFloat {
        let val = (ecoCalculator.netEmission(usageData: usageData, tipData: tipData) - goalEmission) / ecoCalculator.netEmission(usageData: usageData, tipData: tipData)
        if val.isNaN {
            return 1
        }
        if !(0 <= val && val <= 1) {
            return 0
        }
        return 1 - val
    }
    
    func adaptGoal(_ val: Double) {
        withAnimation {
            goalEmission = val * ecoCalculator.netEmission(usageData: usageData, tipData: tipData)
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
