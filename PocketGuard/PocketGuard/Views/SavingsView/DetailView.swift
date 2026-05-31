//
//  DetailView.swift
//  PocketGuard
//
//  Created by Cedrick on 5/28/26.
//

import SwiftUI

struct DetailView: View {
    @State var isAddAmount: Bool = false
    @State var isWithdrawAmount: Bool = false
    
    @State var saved: Double
    @State var target: Double
    
    @State private var transactions: [Transaction] = []
    @StateObject private var vm = DetailViewModel()
    
    let navigationTitle: String
    let image: UIImage?
    
    var progress: CGFloat {
        guard target > 0 else { return 0 }
        return min(saved / target, 1)
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
                    
                    ForEach(transactions.prefix(5)) { tx in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(tx.type == .add ? StringEnums.added.rawValue : StringEnums.withdrawn.rawValue)
                                    .font(.subheadline)
                                
                                Text(tx.date.formattedShort())
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text("\(StringEnums.pesoSign.rawValue)\(tx.amount, format: .number.precision(.fractionLength(2)))")
                                .foregroundColor(tx.type == .add ? .green : .red)
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    Spacer(minLength: 20)
                }
                .padding(.top)
            }
            
            if isAddAmount {
                CenterAmountPopup(isPresented: $isAddAmount) { addAmount in
                    saved += addAmount
                    vm.addDeposit()




                }
            }
            
            if isWithdrawAmount {
                CenterAmountPopup(isPresented: $isWithdrawAmount) { withdrawAmount in
                    let finalAmount = min(withdrawAmount, saved)
                    saved -= finalAmount
                    
                    transactions.insert(
                        Transaction(amount: finalAmount, type: .withdraw),
                        at: 0
                    )
                }
            }
        }
        .navigationTitle(navigationTitle)
    }
}


import RealmSwift

@MainActor
class DetailViewModel: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    @Published var balance: Double = 0
    
    private let service = TransactionService()
    
    func loadData() {
        let results = service.fetchTransactions()
        
        transactions = Array(results)
        
        balance = transactions.reduce(0) { result, transaction in
            
            switch transaction.type {
            case .deposit:
                return result + transaction.amount
                
            case .withdrawal:
                return result - transaction.amount
            }
        }
    }
    
    func addDeposit() {
        try? service.addDeposit(amount: 1000)
        
        loadData()
    }
}
