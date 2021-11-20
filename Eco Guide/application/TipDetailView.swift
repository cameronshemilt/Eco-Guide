//
//  TipDetailView.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 20.11.21.
//

import SwiftUI

struct TipDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var moc
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
                CarbonYearlyTitleView(value: -739, title: "")
                    .foregroundColor(.green)
            }
            .padding(.bottom, 35)
            
            Text(tip.description)
                .multilineTextAlignment(.center)
            
            Spacer()
            Button("Accept", action: {
                let entry = AcceptedTipEntry(context: moc)
                entry.id = Int64(tip.id)
                entry.timestamp = Date.now
                do {
                    try moc.save()
                } catch {
                    print("COULD NOT SAVE!")
                }
                dismiss()
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
            TipDetailView(tip: Tip.mockTips[0])
                .background(Color.backgroundColor)
        }
    }
}
