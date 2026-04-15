//
//  AddCardView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/15/26.
//

import SwiftUI

struct AddCardView: View {
    var onAdd: () -> Void
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
            
            Button {
                onAdd()
            } label: {
                Text("+")
                    .font(.system(size: 50, weight: .regular))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 120, height: 110)
        .cornerRadius(10)
    }
}
