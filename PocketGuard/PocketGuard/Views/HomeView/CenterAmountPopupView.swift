//
//  CenterAmountPopupView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/16/26.
//

import SwiftUI

struct CenterAmountPopup: View {
    @FocusState private var isFocused: Bool
    @Binding var isPresented: Bool
    
    @State private var amountText: String = ""

    var onSave: (Double) -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 20) {
                
                Text(StringEnums.enterAmount.rawValue)
                    .font(.headline)
                
                TextField(StringEnums.defaultAmount.rawValue, text: $amountText)
                    .keyboardType(.decimalPad)
                    .padding(8)
                    .overlay (
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isFocused ? Color.blue : Color.gray, lineWidth: 1.5)
                    )
                    .focused($isFocused)
                
                HStack {
                    Button(StringEnums.cancel.rawValue) {
                        isPresented = false
                    }
                    
                    Spacer()
                    
                    Button(StringEnums.save.rawValue) {
                        guard let amount = Double(amountText), amount != 0 else { return }
                        onSave(amount)
                        isPresented = false
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .frame(maxWidth: 300)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 20)
        }
    }
}
