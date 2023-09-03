//
//  TodoListItemsView.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct TodoListView: View {
    
    @StateObject private var viewModel  = TodoListViewModel()
    @FirestoreQuery var items : [TodoItem]
    
    private var userId : String
    
    init (userId : String) {
        self.userId = userId
        self._items = FirestoreQuery(
            collectionPath: "\(Constanst.USER_COLLECTION)/\(userId)/\(Constanst.TODO_COLLECTION)")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !items.isEmpty {
                    List(items) { item in
                        TodoListItemView(item: item)
                            .swipeActions(edge : .trailing,allowsFullSwipe: false) {
                                Button("Delete") {
                                    viewModel.showDeleteAlert = true
                                    viewModel.setItemToDelete(item: item)
                                }
                                .tint(.red)
                            }
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Text("No Todos Found")
                        .font(.title)
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }

            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
            .alert(isPresented: $viewModel.showDeleteAlert) {
                    
                    Alert(title: Text("Delete Todo?"), primaryButton: .destructive(Text("Delete")) {
                        viewModel.deleteItem(id: viewModel.getItemToDelete()!.id)
                    }, secondaryButton: .cancel())
                
            }
        }
        
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(userId: "FNdcX0I4NObB9rwGeFA0KpKqT2D3")
    }
}
