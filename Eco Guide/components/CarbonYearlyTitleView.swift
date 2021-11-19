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
        HStack(alignment: .top, spacing: 0) {
            Text("\(value)")
                .font(.system(.largeTitle, design: .rounded).bold())
                .padding(.top, -4)
                .padding(.trailing, 4)
            
            Text("kg CO2")
            Text(" / year")
        }
        .textCase(.uppercase)
        .font(.system(.title3, design: .rounded).bold())
    }
}

struct CarbonYearlyTitleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CarbonYearlyTitleView(value: -7)
                .foregroundColor(.green)
                .padding(.top, 30)
            Spacer()
        }
    }
}
