//
//  LoginView.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import SwiftUI

struct LoginView: View {
  
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "TODO List",
                           subtitle: "Get Things Done",
                           rotation: 15,
                           background: Color.pink
                )
                
                
                
                // Login Form
                Form {
                    
                    TextField("Email Address", text : $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    if !viewModel.isSigningIn {
                        TLButton(title: "Login", background: Color.blue) {
                            // login
                            viewModel.login()
                        }
                    } else {
                        HStack(alignment : .center) {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }

                }
                .offset(y : -50)
                
                // Create Account
                
                VStack {
                    Text("Don't have an account?")
                    
                    NavigationLink("Create An Account", destination: RegisterView())
                        .foregroundColor(Color.blue)
                    
                }
                .padding(.bottom,40)
                
                Spacer()
            }
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(title: Text(viewModel.errorMsg))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
