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
            VStack(spacing: 30) {
                // Title
                CarbonYearlyTitleView(value: -7)
                    .padding(.top, 45)
                    .padding(.bottom, 15)
                
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
                        Circle()
                            .frame(width: 80, height: 80)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Story Section
                HStack {
                    Circle().frame(width: 50, height: 50)
                    Spacer()
                    Circle().frame(width: 50, height: 50)
                    Spacer()
                    Circle().frame(width: 50, height: 50)
                    Spacer()
                    Circle().frame(width: 50, height: 50)
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                // chart section
                
                Spacer()
            }
            .padding(.horizontal)
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
