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
            List(viewModel.profileObjects, id: \.id) { profile in
                CustomProgressBarView(profile: profile)
                .swipeActions(content: {
                    Button(role: .destructive) {
                        viewModel.delete(profile)
                    } label: {
                        Label(StringEnums.delete.rawValue, systemImage: "trash")
                    }
                })
            }
            .listStyle(.insetGrouped)
            .navigationTitle(StringEnums.myGoals.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $isCreateNewGoal) {
                CreateGoalView(
                    name: "",
                    amount: 0,
                    savedAmount: 0
                )
                .environmentObject(viewModel)
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

