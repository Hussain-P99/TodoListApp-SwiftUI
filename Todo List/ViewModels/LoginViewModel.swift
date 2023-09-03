//
//  LoginViewModel.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import FirebaseAuth
import Foundation

class LoginViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMsg = ""
    @Published var isSigningIn = false
    @Published var showErrorAlert = false
    
    init() {}
    
    
    func login() {
        errorMsg = ""
        guard validate() else {
            return
        }
        print("Called")
        print("\(email)")
        print("\(password)")
        isSigningIn = true

        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] data, error in
            self?.isSigningIn = false
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                self?.errorMsg = error?.localizedDescription ?? ""
                self?.showErrorAlert = true
                return
            }
            
            
            
            
        }
    }
    
    
    func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMsg = "Invalid Email or Password"
            return false
        }
        
        guard email.isValidEmail() else {
            errorMsg = "Please enter a valid email"
            return false
        }
        return true
    }
    
    func resetPassword() {
        
    }
    
}
