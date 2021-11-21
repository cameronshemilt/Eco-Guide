//
//  SavingsView.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI
import SFSafeSymbols

struct SavingsView: View {
    @FetchRequest(entity: AcceptedTipEntry.entity(), sortDescriptors: []) private var tipData: FetchedResults<AcceptedTipEntry>
    @FetchRequest(entity: UsageEntry.entity(), sortDescriptors: []) private var usageData: FetchedResults<UsageEntry>
    @State private var selectedCategory: Categories? = nil
    @State private var selectedTip: Tip? = nil
    @State private var showBeginner = true
    
    @ObservedObject private var tipManager = TipManager()
    @ObservedObject private var calculator = EcoCalculator()

    var openTips: [Tip] {
        tipManager.data.filter({ tip in
            !tipData.contains(where: { $0.id == tip.id }) && (tip.category == selectedCategory || selectedCategory == nil)
        })
    }
    var acceptedTips: [Tip] {
        tipManager.data.filter({ tip in
            tipData.contains(where: { $0.id == tip.id }) && (tip.category == selectedCategory || selectedCategory == nil)
        })
    }
    
    var body: some View {
        ScrollView {
            Group {
                CarbonYearlyTitleView(value: calculator.sumSavings(tipData: tipData), title: "Total Savings")
                    .foregroundColor(.green)
                    .padding(.vertical, 25)
                tagSelector
                    .padding(.bottom, 5)
                if showBeginner && selectedCategory == nil {
                    basicSaversCard
                }
                tipsList
                    .padding(.bottom)
            }
            .padding(.horizontal)
        }
        .sheet(item: $selectedTip) { tip in
            NavigationView {
                TipDetailView(tip: tip)
                    .background(Color.backgroundColor)
            }
            .statusBar(hidden: true)
            .preferredColorScheme(.light)
        }
    }
        
    private var tagSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button("All", action: {
                    selectedCategory = nil
                })
                    .foregroundColor(selectedCategory == nil ? .white : .black)
                    .buttonStyle(TagButtonStyle(active: selectedCategory == nil, color: .green))
                
                ForEach(Categories.allCases, id: \.self) { category in
                    Button(category.name, action: {
                        selectedCategory = category
                    })
                        .foregroundColor(selectedCategory == category ? .white : .black)
                        .buttonStyle(TagButtonStyle(active: selectedCategory == category, color: .green))
                }
            }
        }
    }
    
    private var basicSaversCard: some View {
        Card {
            HStack {
                VStack(alignment: .leading) {
                    Text("Get started with basic savers!")
                        .font(.title3)
                        .bold()
                        .padding(.bottom, 3)
                    VStack(alignment: .leading, spacing: 3) {
                        Text("• Recycle Waste")
                        Text("• Renewable Energy")
                        Text("• Public Transport")
                        Text("• Use local produce")
                    }
                    .foregroundColor(.secondary)
                }
                Spacer(minLength: 0)
            }
        }
        .overlay(alignment: .topTrailing) {
            Button(action: { showBeginner = false }, label: {
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
            ForEach(openTips+acceptedTips) { tip in
                Button(action: { selectedTip = tip }) {
                    Card(alignment: .leading) {
                        HStack {
                            if acceptedTips.contains(where: { $0.id == tip.id }) {
                                Image(systemSymbol: .checkmarkCircleFill)
                                    .foregroundColor(.green)
                            }
                            Text(tip.title)
                        }
                            .font(.title2)
                        Text(tip.description)
                            .foregroundColor(.secondary)
                        HStack {
                            Spacer()
                            UnitText(tip.callback().formattedUnitText, unit: "KG CO2")
                                .fontSize(30)
                        }
                        .foregroundColor(.green)
                    }
                }
                .buttonStyle(.plain)
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
