//
//  TodoListViewModel.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


class TodoListViewModel : ObservableObject {
    
    @Published var showingNewItemView = false
    @Published var errorMsg = ""
    @Published var showDeleteAlert = false
    private var itemToDelete : TodoItem?
    
    
    func deleteItem(id : String) {
        let auth = Auth.auth()
        guard let userId = auth.currentUser?.uid else {
            itemToDelete = nil
            return
        }
        let db = Firestore.firestore()
        db.collection(Constanst.USER_COLLECTION)
            .document(userId)
            .collection(Constanst.TODO_COLLECTION)
            .document(id)
            .delete { [weak self] error in
                if error != nil {
                    self?.errorMsg = error?.localizedDescription ?? ""
                }
                self?.itemToDelete = nil
            }
    }
    
    
    func setItemToDelete(item : TodoItem?) {
        self.itemToDelete = item
    }
    
    func getItemToDelete() -> TodoItem? {
        return itemToDelete
    }
}
