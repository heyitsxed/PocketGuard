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
    let image: UIImage?
}

import SwiftUI

struct SavingsView: View {
    @State var container: [SavingProfile] = []
    @State private var isCreateNewGoal: Bool = false
    
    var body: some View {
        NavigationStack {
            List(container) { item in
                HStack {
                    CustomProgressBarView(name: item.name, progress: item.progress, amount: item.amount, image: item.image)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(StringEnums.myGoals.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $isCreateNewGoal) {
                CreateGoalView(name: "", amount: 0, savedAmount: 0, onSavePlan: { newGoal in
                    container.append(newGoal)
                    isCreateNewGoal = false
                })
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    SavingsView()
}

