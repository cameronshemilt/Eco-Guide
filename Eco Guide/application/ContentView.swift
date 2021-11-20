//
//  ContentView.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 19.11.21.
//

import SwiftUI
import CoreData
import SFSafeSymbols

struct ContentView: View {
    var body: some View {
        TabView {
            TabViewElement {
                HomeView()
            }
            .background(Color.backgroundColor)
            .tabItem {
                Label("Home", systemSymbol: .house)
            }
            
            TabViewElement {
                SavingsView()
            }
            .background(Color.backgroundColor)
            .tabItem {
                Label("Savings", systemSymbol: .leafFill)
            }
            
            TabViewElement {
                UsageView()
            }
            .background(Color.redBackgroundColor)
            .tabItem {
                Label("Usage", systemSymbol: .carFill)
            }
        }
    }
}

fileprivate struct TabViewElement<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
