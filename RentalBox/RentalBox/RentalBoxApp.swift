//
//  RentalBoxApp.swift
//  RentalBox
//
//  Created by MBSoo on 2023/04/11.
//

import SwiftUI

@main
struct RentalBoxApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
