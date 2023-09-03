//
//  MainViewViewModel.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import Foundation
import FirebaseAuth

class MainViewModel : ObservableObject {
    
    @Published var currentUserId : String = ""
    
    private var handler : AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn : Bool {
        return Auth.auth().currentUser != nil
    }
    
}
