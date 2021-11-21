//
//  Forest.swift
//  Eco Guide
//
//  Created by Miká Kruschel on 20.11.21.
//

import SwiftUI

struct Forest: View, Equatable {
    let count: Int
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {

                Group {
                    ForEach(1...count, id: \.self) { i in
                        Image("tree\(i%6)")
                            .scaleEffect(.random(in: 0.7...1.2), anchor: .bottom)
                            .offset(x: ((CGFloat(i)/CGFloat(count)) - 0.5) * geo.size.width * 0.95 * .random(in: 0.95...1.05))
                    }
                }
                .padding(.bottom, 78)
                
                Image("floor")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: 0)
            }
            .frame(width: nil, height: geo.size.height, alignment: .bottom)
        }
        .frame(height: 200)
//        .border(.red)
    }
    
    static func ==(lhs: Forest, rhs: Forest) -> Bool {
        return lhs.count == rhs.count
    }
}

struct Forest_Previews: PreviewProvider {
    static var previews: some View {
        Forest(count: 15)
    }
}
