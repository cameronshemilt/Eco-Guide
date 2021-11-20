//
//  UsageView.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

struct UsageView: View {
    @State private var selectedCategory: Categories? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                // Title
                #warning("missing text: you use")
                CarbonYearlyTitleView(value: -7)
                    .foregroundColor(.red)
                    .padding(.top, 45)
                    .padding(.bottom, 30)
                
                // filters
                tagSelector
                
                // usage list
                Card {
                    VStack(alignment: .leading) {
                        Text("Get started with basic savers!")
                            .font(.title3)
                            .bold()
                        HStack(alignment: .top, spacing: 15) {
                            Text("You have set yourself a goal of being carbon neutral.")
                                .foregroundColor(.secondary)
                            
                            Circle()
                                .frame(width: 80, height: 80)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                
                // emission calculator
                
            }
            .padding(.horizontal)
        }
    }
    
    private var tagSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button("All", action: {
                    selectedCategory = nil
                })
                    .buttonStyle(TagButtonStyle(active: selectedCategory == nil, color: .red))
                
                ForEach(Categories.allCases, id: \.self) { category in
                    Button(category.name, action: {
                        selectedCategory = category
                    })
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
