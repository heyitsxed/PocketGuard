//
//  SavingsView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/20/26.
//

import SwiftUI

struct SavingsView: View {
    @StateObject private var viewModel = SavingsViewModel()
    @State private var showDeleteAlert: Bool = false
    @State private var isCreateNewGoal: Bool = false
    
    var body: some View {
        NavigationStack {
            List(viewModel.profiles) { item in
                CustomProgressBarView(
                    name: item.name,
                    progress: item.progress,
                    amount: item.amount,
                    savedAmount: item.saved,
                    image: item.image
                )
                .swipeActions(content: {
                    Button(role: .destructive) {
                        viewModel.delete(item)
                    } label: {
                        Label(StringEnums.delete.rawValue, systemImage: "trash")
                    }
                })
            }
            .listStyle(.insetGrouped)
            .navigationTitle(StringEnums.myGoals.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $isCreateNewGoal) {
                CreateGoalView(name: "", amount: 0, savedAmount: 0, onSavePlan: { newGoal in
                    viewModel.profiles.append(newGoal)
                    isCreateNewGoal = false
                })
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "plus")
                        .onTapGesture { isCreateNewGoal = true }
                }
            }
            .task { viewModel.loadData() }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    SavingsView()
}

