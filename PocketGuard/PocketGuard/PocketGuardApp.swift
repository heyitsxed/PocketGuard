//
//  PocketGuardApp.swift
//  PocketGuard
//
//  Created by Cedrick on 4/13/26.
//

import SwiftUI

@main
struct PocketGuardApp: App {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
