//
//  SummaryCardView.swift
//  PocketGuard
//
//  Created by Cedrick on 6/10/26.
//

import SwiftUI

struct SummaryCardView: View {
    
    @State private var isSensitiveDataHidden: Bool = false

    let totalSaved: Double
    let totalAmount: Double

    var progress: Double {
        totalSaved / totalAmount
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.9),
                    Color.indigo
                ],
                startPoint: .leading,
                endPoint: .trailing
            )

            HStack {
                VStack(alignment: .leading, spacing: 12) {

                    HStack(spacing: 6) {
                        Text(StringEnums.totalSaved.rawValue)
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.9))

                        Image(systemName: "eye.fill")
                            .foregroundColor(.white.opacity(0.8))
                            .onTapGesture {
                                isSensitiveDataHidden.toggle()
                            }
                    }
                    
                    if isSensitiveDataHidden {
                        Text(StringEnums.maskBalance.rawValue)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(StringEnums.maskBalanceProgress.rawValue)
                            .font(.system(size: 12.5, weight: .semibold))
                            .foregroundColor(.white.opacity(0.85))

                    } else {
                        Text("₱\(totalSaved, format: .number.precision(.fractionLength(2)))")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("of ₱\(totalAmount, format: .number.precision(.fractionLength(2)))")
                            .font(.system(size: 12.5, weight: .semibold))
                            .foregroundColor(.white.opacity(0.85))
                    }

                    ProgressView(value: progress)
                        .tint(.green)
                        .frame(height: 8)

                    Text("\(progress * 100, format: .number.precision(.fractionLength(2)))% overall progress")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.85))
                }

                Spacer()

                Image("wallet-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
            }
            .padding(24)
        }
        .frame(height: 175)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .blue.opacity(0.25), radius: 15, y: 8)
        .padding(.horizontal)
    }
}
