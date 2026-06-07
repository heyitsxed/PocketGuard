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
            Group {
                if viewModel.profileObjects.isEmpty {
                    VStack(spacing: 16) {
                        Spacer()

                        Image("empty-state")
                            .resizable()
                            .scaledToFit()
                        
                        Text(StringEnums.emptySavingState.rawValue)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        
                        Spacer()
                        Spacer()
                    }
                } else {
                    List(viewModel.profileObjects) { profile in
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
                }
            }
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
                    Button {
                        isCreateNewGoal = true
                    } label: {
                        Image(systemName: "plus")
                    }
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

