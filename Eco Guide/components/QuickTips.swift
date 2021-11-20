//
//  QuickTips.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 20.11.21.
//

import SwiftUI

struct QuickTips: View {
    var body: some View {
        VStack {
            HStack {
                ProgressBar(value: 1)
                ProgressBar(value: 0.3)
                ProgressBar(value: 0)
            }

            Spacer()

            Text("Try taking a shorter shower")
                .font(.largeTitle.bold())
                .padding(.bottom, 30)
            Text("Every minute you shower shorter, you reduce carbon emissions by 837 grams")
                .font(.title3)
            
            Spacer()
            
            Image(systemSymbol: .squareAndArrowUp)
                .font(.largeTitle)
        }
        .shadow(radius: 15)
        .padding(.horizontal, 30)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background {
            Image("forest")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            Color.black
                .ignoresSafeArea()
                .opacity(0.3)
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.white)
    }
}

fileprivate struct ProgressBar: View {
    let value: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(self.value * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
//                    .animation(.linear)
            }.cornerRadius(45.0)
        }
        .frame(height: 10)
    }
}


struct QuickTips_Previews: PreviewProvider {
    static var previews: some View {
        QuickTips()
    }
}
