//
//  ProfileView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/24/26.
//

import SwiftUI

struct ProfileView: View {
    @State var name: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                Spacer()
            }
            
            Spacer()
            
            List {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
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
                
                Section(header: Text("Social Media")) {
                    Text("@Cedrick")
                }
                
                Section(header: Text("Dark Mode")) {
                    Text("Change Password")
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    ProfileView()
}
