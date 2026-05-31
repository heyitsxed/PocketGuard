//
//  Transaction.swift
//  PocketGuard
//
//  Created by Cedrick on 5/29/26.
//

import Foundation
import RealmSwift

enum TransactionType: String, PersistableEnum {
    case deposit
    case withdrawal
}

class SavingTransaction: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var amount: Double
    @Persisted var type: TransactionType
    @Persisted var createdAt: Date = Date()

}
