//
//  HomeView.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            Group {
                // Title
                totalValue
                    .padding(.vertical, 25)

                // Goal card
                Card {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Your Goal")
                                .font(.title3)
                                .bold()
                            Text("You have set yourself a goal of being carbon neutral.")
                                .foregroundColor(.secondary)
                        }
                        .padding(.trailing)
                        Spacer(minLength: 0)
                        
                        ProgressRing(0.78, color: .green)
                            .diameter(80)
                            .padding(5)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Story Section
                HStack {
                    ForEach(Categories.allCases, id: \.self) { category in
                        StoryPreview(category: category, seen: false, size: 50)
                        if Categories.allCases.last != category {
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                // chart section
                #warning("todo: chart section")
            }
            .padding(.horizontal)
        }
//        .fullScreenCover(isPresented: $story) {
//            QuickTips(tips: Tip.mockTips)
//        }
    }
    
    private var totalValue: some View {
        VStack{
            Text("Total Footprint")
                .font(.subheadline)
                .foregroundColor(.secondary)
            CarbonYearlyTitleView(value: -7)
                .foregroundColor(.green)
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
