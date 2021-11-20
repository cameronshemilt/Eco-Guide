//
//  CarbonYearlyTitleView.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

struct CarbonYearlyTitleView: View {
    let value: Double
    let title: String
    
    var body: some View {
        VStack{
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            VStack(alignment: .center, spacing: 0) {
                Text(value.formattedUnitText)
                    .font(.system(.largeTitle, design: .rounded).bold())
                    .padding(.top, -4)
                    .padding(.trailing, 4)
                
                Text("kg CO2 / year")
            }
            .textCase(.uppercase)
            .font(.system(.title3, design: .rounded).bold())
        }
    }
}

struct CarbonYearlyTitleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CarbonYearlyTitleView(value: -7573, title: "Total savings")
                .foregroundColor(.green)
                .padding(.top, 30)
            CarbonYearlyTitleView(value: 7573, title: "You Use")
                .foregroundColor(.red)
                .padding(.top, 30)
            Spacer()
        }
    }
}
