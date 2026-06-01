//
//  Transaction.swift
//  PocketGuard
//
//  Created by Cedrick on 5/29/26.
//

import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    let amount: Double
    let type: TransactionType
    let date = Date()
}

enum TransactionType {
    case add
    case withdraw
}
