//
//  HomePage.swift
//  PocketGuard
//
//  Created by Cedrick on 4/13/26.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.9)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Pocket Guard")
                    .font(.title)
                    .foregroundColor(.white)
                
                HStack {
                    Text("Welcome Back Ced!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.leading, 15)

                    Spacer()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomePage()
}
