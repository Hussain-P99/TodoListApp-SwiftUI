//
//  RegisterViewModel.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import FirebaseAuth
import Foundation
import FirebaseFirestore

class RegisterViewModel : ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMsg = ""
    @Published var isRegistering = false
    @Published var showErrorAlert = false
    
    
    init() {}
    
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty, !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            showErrorAlert = true
            errorMsg = "Invalid Input"
            return false
        }
        
        
        guard email.isValidEmail() else {
            showErrorAlert = true
            errorMsg = "Invalid Email"
            return false
        }
        
        guard password.count >= Constanst.PASSWORD_LENGTH else {
            showErrorAlert = true
            errorMsg = "Password must be greater than or equal to \(Constanst.PASSWORD_LENGTH)"
            return false
        }
        
        return true
    }
    
    
    func register() {
        guard validate() else {
            return
        }
        
        isRegistering = true
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            self?.isRegistering = false
            guard error == nil else {
                self?.showErrorAlert = true
                self?.errorMsg = error?.localizedDescription ?? ""
                return
            }
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id : String) {
        let user = User(id: id,
                        name: name,
                        email: email,
                        joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection(Constanst.USER_COLLECTION)
            .document(id)
            .setData(user.asDictionary())
    }
    
    
}
