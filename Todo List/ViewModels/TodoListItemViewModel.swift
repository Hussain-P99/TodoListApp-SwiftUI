//
//  TodoListItemViewModel.swift
//  Todo List
//
//  Created by Hussain on 02/09/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class TodoListItemViewModel : ObservableObject {

    
    init() {}
    
    func toggleIsDone(item : TodoItem) {
        var newItem = item
        newItem.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection(Constanst.USER_COLLECTION)
            .document(uid)
            .collection(Constanst.TODO_COLLECTION)
            .document(item.id)
            .setData(newItem.asDictionary())
    }
    
}
