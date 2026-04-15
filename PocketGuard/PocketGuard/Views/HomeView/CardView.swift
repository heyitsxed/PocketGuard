//
//  CardView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/15/26.
//

import SwiftUI

struct CardView: View {
    let amount: Double
    let isCardViewTapped: (() -> Void)
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text(StringEnums.savings.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                
                Text("₱\(String(format: "%.2f", amount))")
                    .font(.system(size: 18, weight: .semibold))
                
            }
        }
        .frame(width: 120, height: 110)
        .cornerRadius(10)
        .onTapGesture {
            isCardViewTapped()
        }
    }
}
