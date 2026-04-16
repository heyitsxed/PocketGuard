//
//  HomePageView.swift
//  PocketGuard
//
//  Created by Cedrick  on 4/13/26.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject private var viewModel = HomePageViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.9)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text(StringEnums.appTitle.rawValue)
                    .font(.title)
                    .foregroundColor(.white)
                
                ZStack {
                    Color.blue
                        .frame(height: 130)
                    
                    VStack(spacing: 10) {
                        Text(StringEnums.netWorth.rawValue)
                            .foregroundColor(.white)
                        
                        Text("₱ \(String(format: "%.2f", viewModel.amounts.reduce(0, +)))")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold))
                    }
                }
                .cornerRadius(20)
                .padding(.horizontal, 15)
                
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing: 10) {
                        ForEach(viewModel.amounts.indices, id: \.self) { index in
                            CardView(amount: viewModel.amounts[index]) {
                                viewModel.selectedIndex = nil
                            }
                            .overlay(alignment: .topTrailing) {
                                if viewModel.selectedIndex == index {
                                    Button {
                                        viewModel.amounts.remove(at: index)
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                            .font(.system(size: 24))
                                            .padding(5)
                                    }
                                }
                            }
                            .onLongPressGesture {
                                viewModel.selectedIndex = index
                            }
                        }
                        
                        AddCardView {
                            withAnimation {
                                viewModel.isShowPopup = true
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
                Spacer()
            }
            
            if viewModel.isShowPopup {
                CenterAmountPopup(isPresented: $viewModel.isShowPopup) { amount in
                    viewModel.amounts.append(amount)
                }
            }
        }
    }
}

#Preview {
    HomePage()
}
