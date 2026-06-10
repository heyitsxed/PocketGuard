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
    
    @State private var path: [Route] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.profileObjects.isEmpty {
                    emptyStateView
                } else {
                    dashboardContentView
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let id):
                    if let profile = viewModel.profileObjects.first(where: { $0.id == id }) {
                        DetailView(path: $path, profile: profile, navigationTitle: profile.name, image: profile.image)
                            .environmentObject(viewModel)
                    }
                case .edit(let id):
                    if let profile = viewModel.profileObjects.first(where: { $0.id == id }) {
                        EditView(path: $path, profile: profile)
                            .environmentObject(viewModel)
                    }
                }
            }
            .fullScreenCover(isPresented: $isCreateNewGoal) {
                CreateGoalView(
                    name: "",
                    amount: 0,
                    savedAmount: 0
                )
                .environmentObject(viewModel)
            }
            .task { viewModel.loadData() }
        }
        .environmentObject(viewModel)
    }
    
    // MARK: - Subviews
    
    private var emptyStateView: some View {
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
            
            HStack {
                Spacer()
                plusButton(iconSize: 24, paddingAmount: 16)
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
            }
        }
    }
    
    private var dashboardContentView: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(StringEnums.appTitle.rawValue)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(StringEnums.trackYourGoals.rawValue)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                plusButton(iconSize: 20, paddingAmount: 10)
            }
            .padding(.horizontal, 15)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            List {
                Section {
                    SummaryCardView(totalSaved: viewModel.totalSaved, totalAmount: viewModel.totalAmount)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .padding(.top, 15)
                }
                
                Section {
                    ForEach(viewModel.profileObjects) { profile in
                        CustomProgressBarView(path: $path, profile: profile)
                            .listRowInsets(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                            .swipeActions(content: {
                                Button(role: .destructive) {
                                    viewModel.delete(profile)
                                } label: {
                                    Label(StringEnums.delete.rawValue, systemImage: "trash")
                                }
                            })
                    }
                } header: {
                    Text(StringEnums.myPocketList.rawValue)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 15)
                        .textCase(nil)
                        .padding(.top, 8)
                }
            }
            .listStyle(.plain)
        }
    }
    
    // MARK: - Helper Builder Functions
    
    private func plusButton(iconSize: CGFloat, paddingAmount: CGFloat) -> some View {
        Button {
            isCreateNewGoal = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: iconSize, weight: .bold))
                .foregroundColor(.white)
                .padding(paddingAmount)
                .background(
                    LinearGradient(
                        colors: [Color.blue.opacity(0.9), Color.indigo],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(Circle())
        }
    }
}
