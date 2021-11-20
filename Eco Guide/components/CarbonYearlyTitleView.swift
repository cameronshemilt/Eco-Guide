//
//  CarbonYearlyTitleView.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

struct CarbonYearlyTitleView: View {
    let value: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(value > 0 ? "+" : "")\(value)")
                .font(.system(.largeTitle, design: .rounded).bold())
                .padding(.top, -4)
                .padding(.trailing, 4)
            
            Text("kg CO2 / year")
        }
        .textCase(.uppercase)
        .font(.system(.title3, design: .rounded).bold())
    }
}

struct CarbonYearlyTitleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CarbonYearlyTitleView(value: -7573)
                .foregroundColor(.green)
                .padding(.top, 30)
            CarbonYearlyTitleView(value: 7573)
                .foregroundColor(.red)
                .padding(.top, 30)
            Spacer()
        }
    }
}
