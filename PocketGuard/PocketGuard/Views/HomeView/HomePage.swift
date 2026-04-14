//
//  HomePage.swift
//  PocketGuard
//
//  Created by Cedrick on 4/13/26.
//

import SwiftUI

struct HomePage: View {
    @State private var amounts: [Double] = [100]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func addRectangle() {
        let amount = Double.random(in: 10...1000)
        amounts.append(amount)
    }
    
    func removedRectangle() {
        amounts.removeAll()
    }
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.9)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Pocket Guard")
                    .font(.title)
                    .foregroundColor(.white)
                
                ZStack {
                    Color.blue
                        .frame(height: 130)
                    
                    VStack(spacing: 10) {
                        Text("Net Worth")
                            .foregroundColor(.white)
                        
                        Text("₱ \(String(format: "%.2f", amounts.reduce(0, +)))")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold))
                    }
                }
                .cornerRadius(20)
                .padding(.horizontal, 15)
                
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(amounts.indices, id: \.self) { index in
                            CardView(amount: amounts[index])
                        }
                        
                        AddCardView {
                            addRectangle()
                        }
                    }
                    .padding(.horizontal, 15)
                }

                Button {
                    removedRectangle()
                } label: {
                    Text("Removed")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
    }
}

struct CardView: View {
    let amount: Double

    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("Savings")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("₱\(String(format: "%.2f", amount))")
                    .font(.system(size: 18, weight: .semibold))
                
            }
        }
        .frame(width: 120, height: 110)
        .cornerRadius(10)
    }
}

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

#Preview {
    HomePage()
}
