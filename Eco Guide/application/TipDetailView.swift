//
//  TipDetailView.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 20.11.21.
//

import SwiftUI

struct TipDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let tip: Tip
    
    var body: some View {
        VStack {
            Text(tip.title)
                .font(.title)
                .padding(.bottom, 20)
            
            Card {
                Text("Based on ous calculations,\nyou could save up to").multilineTextAlignment(.center)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                CarbonYearlyTitleView(value: -739)
                    .foregroundColor(.green)
            }
            .padding(.bottom, 35)
            
            Text(tip.description)
                .multilineTextAlignment(.center)
            
            Spacer()
            Button("ACCEPT", action: {
                #warning("Implement")
            })
                .buttonStyle(PrimaryButtonStyle())
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", action: { dismiss() })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TipDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        TipDetailView(tip: Tip(id: 1, title: "Using renewable energy",
                               description: "Lorem ipsum dolor sit met et circensum, vite cum lautet amica Quintus circus et domicil marcus Aurelius familia.",
                               category: .living))
                .background(Color.backgroundColor)
        }
    }
}
