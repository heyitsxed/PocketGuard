//
//  SavingsView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/20/26.
//

import SwiftUI

enum Route: Hashable {
    case detail(SavingProfile)
    case edit(SavingProfile)
}

struct SavingsView: View {
    @StateObject private var viewModel = SavingsViewModel()
    @State private var showDeleteAlert: Bool = false
    @State private var isCreateNewGoal: Bool = false
    
    @State private var path: [Route] = []
    
    var body: some View {
        NavigationStack(path: $path) {
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
                        CustomProgressBarView(path: $path, profile: profile)
                            .swipeActions(content: {
                                Button(role: .destructive) {
                                    viewModel.delete(profile)
                                } label: {
                                    Label(StringEnums.delete.rawValue, systemImage: "trash")
                                }
                            })
                    }
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .detail(let profile):
                            DetailView(path: $path, profile: profile, navigationTitle: profile.name, image: profile.image)
                                .environmentObject(viewModel)

                        case .edit(let profile):
                            EditView(path: $path, profile: profile)
                                .environmentObject(viewModel)
                        }
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

