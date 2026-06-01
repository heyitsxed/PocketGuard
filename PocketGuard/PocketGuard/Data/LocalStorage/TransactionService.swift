//
//  TransactionService.swift
//  PocketGuard
//
//  Created by Cedrick on 6/1/26.
//

import RealmSwift

final class TransactionService {
    
    private let realm = try! Realm()
    
    func addDeposit(amount: Double) throws {
        let realm = try Realm()

        let transaction = SavingTransaction()
        transaction.amount = amount
        transaction.type = .deposit

        try realm.write {
            realm.add(transaction)
        }
    }
    
    func addWithdrawal(amount: Double) throws {
        let transaction = SavingTransaction()
        
        transaction.amount = amount
        transaction.type = .withdrawal
        
        try realm.write {
            realm.add(transaction)
        }
    }
    
    func fetchTransactions() -> Results<SavingTransaction> {
        realm.objects(SavingTransaction.self)
            .sorted(byKeyPath: "createdAt", ascending: false)
    }
}
