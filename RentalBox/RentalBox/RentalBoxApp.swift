//
//  RentalBoxApp.swift
//  RentalBox
//
//  Created by MBSoo on 2023/04/11.
//

import SwiftUI

@main
struct RentalBoxApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(UserVM())
//                .environmentObject(FixtureViewModel())
        }
    }
}
