//
//  ContentView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/13/26.
//

import SwiftUI

struct MainTabView:View {
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            HomePageView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Savings")
                }
            
            HomePageView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainTabView()
}
