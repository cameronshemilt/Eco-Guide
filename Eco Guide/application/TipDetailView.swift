//
//  TipDetailView.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 20.11.21.
//

import SwiftUI

struct TipDetailView: View {
    @FetchRequest(entity: AcceptedTipEntry.entity(), sortDescriptors: []) private var data: FetchedResults<AcceptedTipEntry>
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var moc
    let tip: Tip
    
    var tipIsDone: Bool {
        return data.contains(where: { $0.id == tip.id })
    }
    
    var body: some View {
        VStack {
            Text(tip.title)
                .font(.title)
                .padding(.bottom, 20)
            
            Card {
                Text("Based on ous calculations,\nyou could save up to")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                CarbonYearlyTitleView(value: tip.callback(), title: "")
                    .foregroundColor(.green)
            }
            .padding(.bottom, 35)
            
            Text(tip.description)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            HStack {
                Text("This will get you")
                UnitText("2", unit: "%")
                    .foregroundColor(.green)
                Text("closer")
            }
            Text("to your total goal.")
                .padding(.top, -16)
            Spacer()
            Button(tipIsDone ? "Undo" : "Accept", action: {
                if tipIsDone {
                    let fetchRequest = AcceptedTipEntry.fetchRequest()
                    
                    if let result = try? moc.fetch(fetchRequest) {
                        if let obj = result.first(where: { ele in
                            return ele.id == tip.id
                        }) {
                            moc.delete(obj)
                        }
                    } else {
                        print("Object not found!")
                    }
                } else {
                    let entry = AcceptedTipEntry(context: moc)
                    entry.id = Int64(tip.id)
                    entry.timestamp = Date.now
                }
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
            TipDetailView(tip: TipManager().data[0])
                .background(Color.backgroundColor)
        }
    }
}
