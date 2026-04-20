//
//  SavingsView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/20/26.
//

struct SavingProfile: Identifiable {
    let id = UUID()
    let name: String
    let progress: Double
    let amount: Double
}

import SwiftUI

struct SavingsView: View {
    @State var container: [SavingProfile] = []
    
    var body: some View {
        VStack {
            Text("My Goals")
                .font(.title)
            
            List(container) { item in
                HStack {
                    CustomProgressBarView(name: item.name, progress: item.progress, amount: item.amount)
                }
            }
            .listStyle(.insetGrouped)
            
            Button {
                let randomGoal = SavingProfile(name: "testing", progress: 0.1, amount: 50000)
                container.append(randomGoal)
            } label: {
                Text("add goal")
            }
        }
    }
}

#Preview {
    SavingsView()
}

