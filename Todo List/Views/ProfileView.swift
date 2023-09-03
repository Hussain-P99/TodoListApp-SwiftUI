//
//  ProfileView.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                        .frame(width: 125, height: 125)
                        .padding()
                    
                    // Info : Name, email
                    VStack {
                        Text("Name")
                            .bold()
                        Text(user.name)
                            .font(.subheadline)
                    }
                    .padding()
                    
                    VStack {
                        Text("Email")
                            .bold()
                        Text(user.email)
                            .font(.subheadline)
                    }
                    .padding()
                    
                    VStack {
                        Text("Member since")
                            .bold()
                        Text(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))
                            .font(.subheadline)
                    }
                    .padding()
                    
                    
                    Spacer()
                    
                    
                    // Sign out
                    
                    
                    Spacer()
                    
                } else {
                    Text("Loading Profile...")
                    
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.blue)
                        .frame(width: 100,height: 42)
                    Button("Logout") {
                        viewModel.showLogoutAlert = true
                    }
                    .bold()
                    .buttonStyle(DefaultButtonStyle())
                    .font(.body)
                    .tint(.white)
                }
                .padding()
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
        .alert(isPresented: $viewModel.showLogoutAlert) {
            Alert(title: Text("Are you sure you want to logout?"),
                  primaryButton: .destructive(Text("Logout")) {
                viewModel.logout()
                },
                  secondaryButton: .cancel())
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
