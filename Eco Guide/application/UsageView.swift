//
//  UsageView.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 19.11.21.
//

import SwiftUI

struct UsageView: View {
    var body: some View {
        Text("Usage!")
    }
}

struct UsageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UsageView()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.backgroundColor)
    }
}
