//
//  ActionButtonsView.swift
//  PocketGuard
//
//  Created by Cedrick on 5/29/26.
//

import SwiftUI

struct ActionButtonsView: View {

    var onAdd: () -> Void
    var onWithdraw: () -> Void
    var onEdit: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Group {
                Button(action: onAdd) {
                    Label("Add Money", systemImage: "plus")
                }
                .buttonStyle(.borderedProminent)
                
                Button(action: onWithdraw) {
                    Label("Withdraw", systemImage: "minus")
                }
                .buttonStyle(.bordered)
                
                Button(action: onEdit) {
                    Label("Edit Goal", systemImage: "pencil")
                }
                .buttonStyle(.bordered)
            }
            .font(.footnote)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .frame(maxWidth: .infinity)
        }
    }
}
