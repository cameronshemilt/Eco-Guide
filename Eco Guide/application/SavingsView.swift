//
//  SavingsView.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

struct SavingsView: View {
    @State private var selectedCategory: Categories? = nil
    
    var body: some View {
        ScrollView {
            Group {
                totalValue
                    .padding(.vertical, 25)
                tagSelector
                    .padding(.bottom, 5)
                basicSaversCard
                tipsList
                    .padding(.bottom)
            }
            .padding(.horizontal)
        }
    }
    
    private var totalValue: some View {
        VStack{
            Text("Total Savings")
                .font(.subheadline)
                .foregroundColor(.secondary)
            CarbonYearlyTitleView(value: -739)
                .foregroundColor(.green)
        }
    }
    
    private var tagSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                FilterTag(text: "All", active: selectedCategory == nil, color: .green)
                
                ForEach(Categories.allCases, id: \.self) { category in
                    FilterTag(text: category.name, active: selectedCategory == category, color: .green)
                }
            }
        }
    }
    
    private var basicSaversCard: some View {
        Card {
            VStack(alignment: .leading) {
                Text("Get started with basic savers!")
                    .font(.title3)
                    .bold()
                HStack(alignment: .top, spacing: 15) {
                    Text("You have set yourself a goal of being carbon neutral.")
                        .foregroundColor(.secondary)
                    
                    ProgressRing(0.78, color: .green)
                        .diameter(80)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .overlay(alignment: .topTrailing) {
            Button(action: {
#warning("todo: functionality")
            }, label: {
                Image(systemSymbol: .xmark)
                    .font(.body.bold())
            })
                .padding()
                .tint(.secondary)
        }
        .padding(.bottom, 10)
    }
    
    private var tipsList: some View {
        VStack(spacing: 15) {
            ForEach(0..<10) { _ in
                Card(alignment: .leading) {
                    Text("Title")
                        .font(.title2)
                    Text("Description")
                        .foregroundColor(.secondary)
                    HStack {
                        Spacer()
                        UnitText("-73", unit: "KG CO2")
                            .fontSize(30)
                    }
                    .foregroundColor(.green)
                }
            }
        }
    }
}

struct SavingsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SavingsView()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.backgroundColor)
    }
}
