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
    
    public var emptyStateView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image("empty-state")
                .resizable()
                .scaledToFit()
                .frame(height: 260)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .shadow(color: Color.black.opacity(0.06), radius: 16, x: 0, y: 8)
                .padding(.horizontal, 24)
            
            VStack(spacing: 8) {
                Text(StringEnums.emptySavingState.rawValue.highlighting("saving journey!", with: .green))
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                
                Text(StringEnums.emptySavingStateSubTitle.rawValue)
                    .font(.system(size: 14, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 40)
                    .lineSpacing(3)
            }
            .padding(.bottom, 8)
            
            goalMetricsSummaryView
                .padding(.horizontal, 4)
            
            goalButtonView
            
            Spacer()
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
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
    
    private var goalMetricsSummaryView: some View {
        ZStack {
            Color.white
                .shadow(color: Color.black.opacity(0.06), radius: 16, x: 0, y: 8)

            HStack {
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "target").foregroundColor(.green)
                    Text(StringEnums.setYourGoals.rawValue).font(.system(size: 11, weight: .semibold))
                    Text(StringEnums.planWhatToAchieve.rawValue)
                        .font(.system(size: 9))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                Divider().frame(height: 50)
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "checkmark.shield.fill").foregroundColor(.green)
                    Text(StringEnums.saveConsistency.rawValue).font(.system(size: 11, weight: .semibold))
                    Text(StringEnums.smallStepsToday.rawValue)
                        .font(.system(size: 9))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                Divider().frame(height: 50)
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "chart.bar").foregroundColor(.green)
                    Text(StringEnums.buildYourFuture.rawValue).font(.system(size: 11, weight: .semibold))
                    Text(StringEnums.secureYourDreams.rawValue)
                        .font(.system(size: 9))
                        .multilineTextAlignment(.center)
                    
                }
                
                Spacer()
            }
        }
        .frame(height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 15)
        .padding(.bottom, 15)
    }
    
    // MARK: - Helper Builder Functions
    
    private var goalButtonView: some View {
        Button {
            isCreateNewGoal = true
        } label: {
            HStack {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(Font.system(size: 14, weight: .bold, design: .default))
                
                Text(StringEnums.createYourFirstPocket.rawValue)
                    .foregroundColor(.white)
                    .font(Font.system(size: 14, weight: .bold, design: .default))
            }
            
        }
        .padding()
        .frame(height: 40)
        .frame(maxWidth: .infinity)
        .background(Color.green)
        .cornerRadius(20)
        .padding(.horizontal, 15)
    }
}
