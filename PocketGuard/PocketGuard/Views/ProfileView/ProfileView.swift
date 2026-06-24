//
//  ProfileView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/24/26.
//

import SwiftUI

struct ProfileView: View {
    @State var name: String = ""
    @State var selectedImage: UIImage?
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Color.blue
                Spacer()
                
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.top, 30)
                    
                } else {
                    Image("wallet-icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 90, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.top, 30)
                }
                
                Spacer()
            }
            .ignoresSafeArea()
            .frame(height: 150)
            
            Spacer()
            
            List {
                Section(header: Text("Name")) {
                    Text("Cedrick")
                }
                
                Section(header: Text("Email")) {
                    Text("cedrick@gmail.com")
                }
                
                Section(header: Text("Phone")) {
                    Text("+63 917 123 4567")
                }
                
                Section(header: Text("Address")) {
                    Text("123 Main St, City, Country")
                }
                
                Section(header: Text("Settings")) {
                    HStack {
                        Toggle("Dark Mode", isOn: $isDarkMode)
                    }
                    
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Logout")
                    }
                }
            }
            
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ProfileView()
}
