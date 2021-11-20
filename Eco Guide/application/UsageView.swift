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
    
    var body: some View {
        ScrollView {
            Group {
                totalValue
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
        Card {
            HStack(spacing: 10) {
                Image(systemSymbol: .carFill)
                    .font(.title.bold())
                    .foregroundColor(.red)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Car")
                        .font(.title2)
                        .bold()
                    Text("35km per Week")
                }
                Spacer()
                Text("+7")
                    .font(.title)
                    .bold()
                    .foregroundColor(.red)
                VStack {
                    Text("kg co2")
                    Text("/ year")
                }.textCase(.uppercase)
            }
        }
    }
    
    private var totalValue: some View {
        VStack{
            Text("You use")
                .font(.subheadline)
                .foregroundColor(.secondary)
            CarbonYearlyTitleView(value: +739)
                .foregroundColor(.red)
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

struct UsageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UsageView()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.redBackgroundColor)
    }
}
