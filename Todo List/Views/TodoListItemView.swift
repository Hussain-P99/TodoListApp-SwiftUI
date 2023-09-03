//
//  TodoListItemView.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import SwiftUI

struct TodoListItemView: View {
    
    let item : TodoItem
    
    @StateObject private var viewModel = TodoListItemViewModel()
    
    var body: some View {
        HStack {
            VStack(alignment : .leading) {
                Text(item.title)
                    .font(.body)
                    .strikethrough(item.isDone)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
                    .strikethrough(item.isDone)

            }
            
            Spacer()
            
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle" )
                    .foregroundColor(.blue)
            }

        }
    }
}

struct TodoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListItemView(item: TodoItem(id: "", title: "Some Title", dueDate: Date().timeIntervalSince1970, createdDate: Date().timeIntervalSince1970, isDone: true))
    }
}
