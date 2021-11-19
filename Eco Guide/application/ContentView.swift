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
            .tabItem {
                Label("Home", systemSymbol: .house)
            }
            
            TabViewElement {
                SavingsView()
            }
            .tabItem {
                Label("Savings", systemSymbol: .sparkle)
            }
            
            TabViewElement {
                UsageView()
            }
            .tabItem {
                Label("Usage", systemSymbol: .sparkle)
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
        .background(Color.backgroundColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
