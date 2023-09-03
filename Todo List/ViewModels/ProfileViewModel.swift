//
//  ProfileViewViewModel.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel : ObservableObject {
    
    @Published var user : User?
    @Published var showLogoutAlert = false
    
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection(Constanst.USER_COLLECTION).document(userId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.user = User(id: data["id"] as? String ?? "",
                                  name: data["name"] as? String ?? "",
                                  email: data["email"] as? String ?? "",
                                  joined: data["joined"] as? TimeInterval ?? 0)
            }
        }
    }
    
    func logout() {
        do {
          try Auth.auth().signOut()
        } catch {
            
        }
    }
    
    func deleteUser() {
        let auth = Auth.auth()
        guard let uid = auth.currentUser?.uid else {
            return
        }
        
        
        auth.currentUser?.delete()
    }
}
