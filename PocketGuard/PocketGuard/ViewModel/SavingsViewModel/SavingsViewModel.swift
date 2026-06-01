//
//  SavingsViewModel.swift
//  PocketGuard
//
//  Created by Cedrick on 6/1/26.
//

import Combine
import Foundation

@MainActor
class SavingsViewModel: ObservableObject {
    
    @Published var transactions: [SavingTransaction] = []
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
    
    func addDeposit(amount: Double) {
        do {
            try service.addDeposit(amount: amount)
            loadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addWithdrawal(amount: Double) {
        do {
            try service.addWithdrawal(amount: amount)
            loadData()
        } catch {
            print(error.localizedDescription)
        }
    }
}
