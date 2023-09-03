//
//  RegisterView.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack {
            HeaderView(title: "Register",
                       subtitle: "Start Organizing todos",
                       rotation: -15,
                       background: .orange)
            
            Form {
                
                TextField("Fullname",text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                
                TextField("Email Address",text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                SecureField("Password",text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                if viewModel.isRegistering {
                    HStack(alignment : .center) {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                } else {
                    TLButton(title: "Create Account", background: .green) {
                        viewModel.register()
                    }
                }
                
            }
            .offset(y : -50)
            
            Spacer()
        }.alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text(viewModel.errorMsg))
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
