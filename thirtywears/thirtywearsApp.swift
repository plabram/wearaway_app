//
//  thirtywearsApp.swift
//  thirtywears
//
//  Created by Penelope Labram on 6/4/21.
//

import SwiftUI

@main
struct thirtywearsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MotherView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(ViewRouter())
        }
    }
}
