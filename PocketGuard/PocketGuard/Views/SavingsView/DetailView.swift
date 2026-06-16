//
//  DetailView.swift
//  PocketGuard
//
//  Created by Cedrick on 5/28/26.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var vm: SavingsViewModel
    
    @State var isAddAmount: Bool = false
    @State var isWithdrawAmount: Bool = false
    @State var isEditTapped: Bool = false
    @Binding var path: [Route]
    
    let profile: SavingProfile
    let navigationTitle: String
    let image: UIImage?
    
    var progress: CGFloat {
        guard target > 0 else { return 0 }
        return min(saved / target, 1)
    }
    
    var saved: Double {
        profile.saved
    }
    
    var target: Double {
        profile.amount
    }
    
    var dailyGoal: Double {
        let remainingAmount = profile.amount - profile.saved
        
        guard remainingAmount > 0 else { return 0.0 }
        
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfTarget = calendar.startOfDay(for: profile.date)
        
        let components = calendar.dateComponents([.day], from: startOfToday, to: startOfTarget)
        let daysRemaining = components.day ?? 0
        
        if daysRemaining <= 0 {
            return remainingAmount
        }
        
        return remainingAmount / Double(daysRemaining)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Color.white
                    HStack {
                        Spacer()
                        PercentageCircle(progress: progress)
                        Spacer()
                        savingProgressionView
                        Spacer()
                    }
                }
                .frame(height: 175)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal, 15)
                .shadow(color: .blue.opacity(0.25), radius: 15, y: 8)
                
                ActionButtonsView(
                    onAdd: {
                        isAddAmount = true
                    },
                    onWithdraw: {
                        isWithdrawAmount = true
                    },
                    onEdit: {
                        isEditTapped = true
                    }
                )
                .padding(.all, 15)
                
                goalMetricsSummaryView
                
                HStack {
                    Text(StringEnums.recentTransactions.rawValue)
                        .font(.headline)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                if profile.transactions.isEmpty {
                    Text(StringEnums.noRecentTransactions.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top)
                } else {
                    ForEach(Array(profile.transactions.prefix(5)), id: \.id) { tx in
                        TransactionRow(tx: tx)
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer(minLength: 20)
                }
            }
            .padding(.top)
        }
        .overlay {
            if isAddAmount {
                CenterAmountPopup(isPresented: $isAddAmount) { addAmount in
                    vm.addDeposit(amount: addAmount, to: profile)
                }
            } else if isWithdrawAmount {
                CenterAmountPopup(isPresented: $isWithdrawAmount) { withdrawAmount in
                    vm.addWithdrawal(amount: withdrawAmount, to: profile)
                }
            }
        }
        .sheet(isPresented: $isEditTapped) {
            EditView(path: $path, profile: profile)
                .environmentObject(vm)
        }
        .navigationTitle(navigationTitle)
    }
    
    
    // MARK: - Subviews
    
    private var savingProgressionView: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            Text(StringEnums.savedAmount.rawValue)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
            
            Text("₱\(Text(saved, format: .number.precision(.fractionLength(2))))")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            
            Text(StringEnums.goalAmount.rawValue)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
                .padding(.top)
            
            Text("₱\(Text(target, format: .number.precision(.fractionLength(2))))")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
        }
    }
    
    private var goalMetricsSummaryView: some View {
        ZStack {
            Color.gray.opacity(0.1)
            HStack {
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "target").foregroundColor(.blue)
                    Text(StringEnums.targetDate.rawValue).font(.system(size: 11))
                    Text(profile.date, style: .date).font(.system(size: 13, weight: .semibold))
                }
                
                Spacer()
                Divider().frame(height: 50)
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "calendar").foregroundColor(.blue)
                    Text(StringEnums.createdOn.rawValue).font(.system(size: 11))
                    Text(profile.createdAt, style: .date).font(.system(size: 13, weight: .semibold))
                }
                
                Spacer()
                Divider().frame(height: 50)
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "chart.bar").foregroundColor(.blue)
                    Text(StringEnums.dailyGoal.rawValue).font(.system(size: 11))
                    Text(dailyGoal, format: .currency(code: "PHP")).font(.system(size: 13, weight: .semibold))
                }
                
                Spacer()
            }
        }
        .frame(height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 15)
        .padding(.bottom, 15)
    }
}
