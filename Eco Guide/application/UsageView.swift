//
//  UsageView.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI
import SFSafeSymbols

struct UsageView: View {
    @State private var selectedCategory: Categories? = nil
    
    @ObservedObject private var ecoCalculator = EcoCalculator()
    @AppStorage(Defaults.diet) private var diet: Diet = .vegan
    @AppStorage(Defaults.driving) private var driving: CarDistance = .tenToThirty
    @AppStorage(Defaults.household) private var household: Household = .one
    @AppStorage(Defaults.trash) private var trash: Trash = .one
    
    var body: some View {
        ScrollView {
            Group {
                CarbonYearlyTitleView(value: ecoCalculator.sumEmission, title: "You use")
                    .foregroundColor(.red)
                    .padding(.vertical, 25)
                
                tagSelector
                    .padding(.bottom, 5)
                
                usageList
                    .padding(.bottom, 30)
                
                HStack {
                    Text("Emission calculator").font(.title3.bold())
                    Spacer(minLength: 0)
                }
                emissionCalc
            }
            .padding(.horizontal)
        }
    }
    
    private struct EmissionCalcItem {
        let symbol: SFSymbol
        let name: String
    }
    private let emissionCalcItems: [EmissionCalcItem] = [
        .init(symbol: .carFill, name: "Car Trip"),
        .init(symbol: .airplaneDeparture, name: "Flight"),
        .init(symbol: .forkKnife, name: "Meat"),
        .init(symbol: .trashFill, name: "Plastic"),
        .init(symbol: .newspaperFill, name: "Paper"),
        .init(symbol: .bagFill, name: "Clothes")
    ]
    private var emissionCalc: some View {
        LazyVGrid(columns: [GridItem.init(.adaptive(minimum: 100, maximum: 300))]) {
            ForEach(emissionCalcItems, id: \.name) { (item: EmissionCalcItem) in
                Card {
                    VStack(spacing: 10) {
                        Image(systemSymbol: item.symbol)
                            .font(.title.bold())
                            .foregroundColor(.red)
                        Text(item.name)
                            .fontWeight(.semibold)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
            }
        }
    }
    
    private var usageList: some View {
        VStack(spacing: 15) {
            UsageCard(title: "Car", subtitle: driving.usageLabel, systemSymbol: .carFill, savings: ecoCalculator.carEmission, visible: selectedCategory == .transport || selectedCategory == nil) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(minimum: 0, maximum: 300), spacing: 0), count: 2), spacing: 0) {
                    ForEach(CarDistance.allCases, id: \.self) { type in
                        Button(action: { driving = type }, label: { Text(type.usageLabel) })
                            .buttonStyle(PrimaryButtonStyle(color: .primary, foregroundColor: .white))
                            .padding(5)
                    }
                }
                .padding(.horizontal, 5)
            }
            UsageCard(title: "Electricity", subtitle: household.usageLabel, systemSymbol: .boltFill, savings: ecoCalculator.electricityEmission, visible: selectedCategory == .housing || selectedCategory == nil) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(minimum: 0, maximum: 300), spacing: 0), count: 2), spacing: 0) {
                    ForEach(Household.allCases, id: \.self) { type in
                        Button(action: { household = type }, label: { Text(type.usageLabel) })
                            .buttonStyle(PrimaryButtonStyle(color: .primary, foregroundColor: .white))
                            .padding(5)
                    }
                }
                .padding(.horizontal, 5)
            }
            UsageCard(title: "Food", subtitle: diet.usageLabel, systemSymbol: .forkKnife, savings: ecoCalculator.foodEmission, visible: selectedCategory == .nutrition || selectedCategory == nil) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(minimum: 0, maximum: 300), spacing: 0), count: 2), spacing: 0) {
                    ForEach(Diet.allCases, id: \.self) { type in
                        Button(action: { diet = type }, label: { Text(type.usageLabel) })
                            .buttonStyle(PrimaryButtonStyle(color: .primary, foregroundColor: .white))
                            .padding(5)
                    }
                }
                .padding(.horizontal, 5)
            }
            UsageCard(title: "Waste", subtitle: trash.usageLabel, systemSymbol: .trashFill, savings: ecoCalculator.wasteEmission, visible: selectedCategory == .wasteReduction || selectedCategory == nil) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(minimum: 0, maximum: 300), spacing: 0), count: 2), spacing: 0) {
                    ForEach(Trash.allCases, id: \.self) { type in
                        Button(action: { trash = type }, label: { Text(type.usageLabel) })
                            .buttonStyle(PrimaryButtonStyle(color: .primary, foregroundColor: .white))
                            .padding(5)
                    }
                }
                .padding(.horizontal, 5)
            }
            UsageCard(title: "Water", subtitle: household.usageLabel, systemSymbol: .dropFill, savings: ecoCalculator.waterEmission, visible: selectedCategory == .housing || selectedCategory == nil) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(minimum: 0, maximum: 300), spacing: 0), count: 2), spacing: 0) {
                    ForEach(Household.allCases, id: \.self) { type in
                        Button(action: { household = type }, label: { Text(type.usageLabel) })
                            .buttonStyle(PrimaryButtonStyle(color: .primary, foregroundColor: .white))
                            .padding(5)
                    }
                }
                .padding(.horizontal, 5)
            }
            UsageCard(title: "Heating", subtitle: household.usageLabel, systemSymbol: .flameFill, savings: ecoCalculator.heatingEmission, visible: selectedCategory == .housing || selectedCategory == nil) {
                LazyVGrid(columns: Array(repeating: .init(.flexible(minimum: 0, maximum: 300), spacing: 0), count: 2), spacing: 0) {
                    ForEach(Household.allCases, id: \.self) { type in
                        Button(action: { household = type }, label: { Text(type.usageLabel) })
                            .buttonStyle(PrimaryButtonStyle(color: .primary, foregroundColor: .white))
                            .padding(5)
                    }
                }
                .padding(.horizontal, 5)
            }
        }
    }
    
    private var tagSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button("All", action: {
                    selectedCategory = nil
                })
                    .foregroundColor(selectedCategory == nil ? .white : .black)
                    .buttonStyle(TagButtonStyle(active: selectedCategory == nil, color: .red))
                
                ForEach(Categories.allCases, id: \.self) { category in
                    Button(category.name, action: {
                        selectedCategory = category
                    })
                        .foregroundColor(selectedCategory == category ? .white : .black)
                        .buttonStyle(TagButtonStyle(active: selectedCategory == category, color: .red))
                }
            }
        }
    }
}

fileprivate struct UsageCard<Content: View>: View {
    let title: String
    let subtitle: String
    let systemSymbol: SFSymbol
    let savings: Double
    
    let visible: Bool
    @State private var expanded: Bool = false
    
    @ViewBuilder let menu: Content
    
    var body: some View {
        if visible {
            Card(innerPadding: 0, shadow: false) {
                card
                    .padding(.bottom, expanded ? 10 : 0)
                if expanded {
                    menu
                        .padding(.bottom, 10)
                }
            }
            .onTapGesture {
                withAnimation {
                    expanded.toggle()
                }
            }
        } else {
            EmptyView()
        }
    }
    
    var card: some View {
        Card {
            HStack(spacing: 10) {
                Image(systemSymbol: systemSymbol)
                    .font(.title.bold())
                    .foregroundColor(.primary)
                    .frame(width: 25)
                    .padding(.trailing, 5)
                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.title2)
                        .bold()
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .minimumScaleFactor(0.8)
                        .lineLimit(1)
                }
                Spacer()
                Text(savings.formattedUnitText)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .bold()
                    .foregroundColor(.red)
                VStack(alignment: .leading) {
                    Text("kg co2")
                    Text("/ year")
                }
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .textCase(.uppercase)
            }
        }
    }
}

struct UsageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UsageView()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.redBackgroundColor)
        
        UsageCard(title: "Test", subtitle: "lorem ipsum dolor sit", systemSymbol: .carFill, savings: -7, visible: true, menu: {})
            .padding()
            .previewLayout(.sizeThatFits)
        
        UsageCard(title: "Test", subtitle: "lorem ipsum dolor sit", systemSymbol: .carFill, savings: -7, visible: true, menu: {
            VStack {
                Text("option 1")
                Text("option 2")
            }
        })
            .padding()
            .background(Color.redBackgroundColor)
            .previewLayout(.sizeThatFits)
    }
}
