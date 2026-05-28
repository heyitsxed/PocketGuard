//
//  DetailView.swift
//  PocketGuard
//
//  Created by Cedrick on 5/28/26.
//

import SwiftUI

struct DetailView: View {
    let navigationTitle: String
    let image: UIImage?
    let progress: CGFloat
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .padding(.horizontal)
                } else {
                    Image("wallet-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .padding(.horizontal)
                }
                
                VStack(spacing: 12) {
                    HStack {
                        Spacer()
                        PercentageCircle(progress: progress)
                        Spacer()
                    }
                    
                    Text("Savings Progress")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                ActionButtonsView(
                    onAdd: { },
                    onWithdraw: { },
                    onEdit: { }
                )
                .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                HStack {
                    Text("Recent Transactions")
                        .font(.headline)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack(spacing: 12) {
                    Text("No transactions yet")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                Spacer(minLength: 20)
            }
            .padding(.top)
        }
        .navigationTitle(navigationTitle)
    }
}

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
                
                Text("complete")
                    .font(.caption)
            }
        }
        .frame(width: 120, height: 120)
    }
}

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

