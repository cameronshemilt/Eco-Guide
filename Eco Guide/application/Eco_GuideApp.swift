//
//  Eco_GuideApp.swift
//  Eco Guide
//
//  Created by Cameron Shemilt on 19.11.21.
//

import SwiftUI

@main
struct Eco_GuideApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .statusBar(hidden: true)
                .preferredColorScheme(.light)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
