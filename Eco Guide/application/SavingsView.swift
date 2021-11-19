//
//  SavingsView.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

struct SavingsView: View {
    var body: some View {
        Text("Savings!")
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
