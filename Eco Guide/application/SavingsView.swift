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
            VStack(spacing: 15) {
                // Title
                CarbonYearlyTitleView(value: -7)
                    .foregroundColor(.green)
                    .padding(.top, 45)
                    .padding(.bottom, 30)
                
                // filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        FilterTag(text: "All", active: selectedCategory == nil, color: .green)
                        
                        ForEach(Categories.allCases, id: \.self) { category in
                            FilterTag(text: category.name, active: selectedCategory == category, color: .green)
                        }
                    }
                }
                
                // basic savers card
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

                // tips section
                #warning("todo: tips section")
                
            }
            .padding(.horizontal)
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
