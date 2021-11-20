//
//  TipDetailView.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 20.11.21.
//

import SwiftUI

struct TipDetailView: View {
    var body: some View {
        VStack {
            Text("Based on ous calculations,\nyou could save up to").multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundColor(.secondary)
            CarbonYearlyTitleView(value: -739)
                .foregroundColor(.green)
            
            Button("ACCEPT", action: {})
                .buttonStyle(PrimaryButtonStyle())
        }
        .padding(.horizontal)
    }
}

struct TipDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TipDetailView()
    }
}
