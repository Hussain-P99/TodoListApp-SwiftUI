//
//  NewItemViewModel.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewItemViewModel : ObservableObject {
    
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    init() {}
    
    func save() {
        guard canSave else {
            return
        }
        
        // Get userId
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Create Model
        let newId = UUID().uuidString
        let newTodo = TodoItem(id: newId,
                               title: title,
                               dueDate: dueDate.timeIntervalSince1970,
                               createdDate: Date().timeIntervalSince1970,
                               isDone: false)
        
        // Save Model
        let db = Firestore.firestore()
        
        db.collection(Constanst.USER_COLLECTION)
            .document(uid)
            .collection(Constanst.TODO_COLLECTION)
            .document(newId)
            .setData(newTodo.asDictionary())
        
    }
    
    
    var canSave : Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        
        return true
    }
    
}
