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
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .padding(.horizontal)
                    } else {
                        Image("wallet-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .padding(.horizontal)
                    }
                    
                    VStack(spacing: 12) {
                        HStack {
                            Spacer()
                            PercentageCircle(progress: progress)
                            Spacer()
                        }
                        
                        Text(StringEnums.savingProgress.rawValue)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text("₱\(Text(saved, format: .number.precision(.fractionLength(2)))) saved")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    ActionButtonsView(
                        onAdd: {
                            isAddAmount = true
                        },
                        onWithdraw: {
                            isWithdrawAmount = true
                        },
                        onEdit: { }
                    )
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
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
                    } else {
                        ForEach(Array(profile.transactions.prefix(5)), id: \.id) { tx in
                            TransactionRow(tx: tx)
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer(minLength: 20)
                    }
                }
                .padding(.top)
            }
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
        .navigationTitle(navigationTitle)
    }
}
