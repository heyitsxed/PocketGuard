//
//  SavingsView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/20/26.
//

import SwiftUI

struct SavingsView: View {
    @State private var isCreateNewGoal: Bool = false
    @StateObject private var viewModel = SavingsViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.profiles) { item in
                HStack {
                    CustomProgressBarView(
                        name: item.name,
                        progress: item.progress,
                        amount: item.amount,
                        savedAmount: item.saved,
                        image: item.image)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(StringEnums.myGoals.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $isCreateNewGoal) {
                CreateGoalView(name: "", amount: 0, savedAmount: 0, onSavePlan: { newGoal in
                    viewModel.profiles.append(newGoal)
                    isCreateNewGoal = false
                }).environmentObject(viewModel)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "plus")
                        .onTapGesture {
                            isCreateNewGoal = true
                        }
                }
            }
        }
    }
}

#Preview {
    SavingsView()
}

