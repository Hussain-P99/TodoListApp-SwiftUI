//
//  NewItemView.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import SwiftUI

struct NewItemView: View {
    
    @StateObject private var viewModel = NewItemViewModel()
    @Binding var newItemPresented : Bool
    
    var body: some View {
        VStack {
            Text("New Item")
                .bold()
                .font(.system(size : 32))
                .padding(.top,50)
            
            Form {
                // Title
                TextField("Todo Name",text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                // Button
                TLButton(title: "Save", background: .pink) {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title : Text("Error"),message: Text("please fill in all the fields and select due date that is today or newer"))
            }
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(newItemPresented: Binding(get: {
            true
        }, set: { _, _ in
            
        }))
    }
}
