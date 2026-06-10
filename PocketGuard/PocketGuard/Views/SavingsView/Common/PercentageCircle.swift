//
//  PercentageCircle.swift
//  PocketGuard
//
//  Created by Cedrick on 5/29/26.
//

import SwiftUI

struct PercentageCircle: View {
    var progress: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 10)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue,
                        style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
            
            VStack {
                Text("\(Int(progress * 100))%")
                    .font(.headline)
                
                Text(StringEnums.complete.rawValue)
                    .font(.caption)
            }
        }
        .frame(width: 120, height: 120)
    }
}
