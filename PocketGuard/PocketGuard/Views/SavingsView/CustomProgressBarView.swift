//
//  CustomProgressBarView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/20/26.
//

import SwiftUI

struct CustomProgressBarView: View {
    @State var isNavigate: Bool = false

    let name: String
    let progress: Double
    let amount: Double
    let image: UIImage?
    
    var body: some View {
        NavigationStack {
            HStack(spacing: 0) {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(.circle)
                } else {
                    Image("wallet-icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(.circle)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(name)")
                        .font(.subheadline)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 12)
                                .foregroundColor(Color.gray.opacity(0.3))
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: geometry.size.width * progress, height: 12)
                                .foregroundColor(.blue)
                                .animation(.easeInOut, value: progress)
                        }
                    }
                    .frame(height: 12)
                    
                    Text("\(Int(progress * 100))% of ₱\(Text(amount, format: .number.precision(.fractionLength(2)))) saved")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                
            }.onTapGesture {
                isNavigate = true
            }
        }
        .navigationDestination(isPresented: $isNavigate) {
            DetailView(navigationTitle: name, image: image, progress: progress)
        }
    }
}
