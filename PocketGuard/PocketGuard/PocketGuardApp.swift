//
//  PocketGuardApp.swift
//  PocketGuard
//
//  Created by Cedrick on 4/13/26.
//

import SwiftUI
import RealmSwift

@main
struct PocketGuardApp: App {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            deleteRealmIfMigrationNeeded: true
        )
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
