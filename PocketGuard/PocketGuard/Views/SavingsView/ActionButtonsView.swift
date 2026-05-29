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
        HStack(spacing: 4) {
            
            Button(action: onAdd) {
                Label("Add", systemImage: "plus")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Button(action: onWithdraw) {
                Label("Minus", systemImage: "minus")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            
            Button(action: onEdit) {
                Label("Edit", systemImage: "pencil")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
