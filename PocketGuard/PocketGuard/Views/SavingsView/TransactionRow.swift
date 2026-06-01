//
//  TransactionRow.swift
//  PocketGuard
//
//  Created by Cedrick on 6/1/26.
//

import SwiftUI

struct TransactionRow: View {
    let tx: SavingTransaction

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(tx.type == .deposit ? StringEnums.added.rawValue : StringEnums.withdrawn.rawValue)
                    .font(.subheadline)
                
                Text(tx.createdAt.formatted())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("₱\(tx.amount, format: .number.precision(.fractionLength(2)))")
                .foregroundColor(tx.type == .deposit ? .green : .red)
        }
    }
}
