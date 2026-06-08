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
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
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
                        onEdit: {
                            isEditTapped = true
                        }
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
                            .padding(.top)
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
        .sheet(isPresented: $isEditTapped) {
            EditView(path: $path, profile: profile)
                .environmentObject(vm)
        }
        .navigationTitle(navigationTitle)
    }
}


struct EditView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: SavingsViewModel
    @Binding var path: [Route]
    
    let profile: SavingProfile
    
    @State private var isEditing: Bool = false
    @State private var amount: Double = 0.0
    
    var body: some View {
        VStack {
            Form {
                Section("Saving Info") {
                    Text(profile.name)
                }
                
                Section("Financial Details") {
                    if isEditing {
                        TextField("Amount", value: $amount, format: .currency(code: "PHP"))
                            .keyboardType(.numberPad)
                            .onSubmit {
                                isEditing = false
                            }
                    } else {
                        Text("₱\(Text(profile.amount, format: .number.precision(.fractionLength(2))))")
                            .onTapGesture {
                                amount = profile.amount
                                isEditing = true
                            }
                    }
                }
                
                Section("Target Date") {
                    Text(profile.id)
                }
                
                Button("Delete Goal") {
                    vm.delete(profile)
                    path.removeAll()
                    dismiss()
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("Edit saving")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
        }
    }
}

