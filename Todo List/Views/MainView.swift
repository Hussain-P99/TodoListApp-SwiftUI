//
//  ContentView.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                // Signed In
                TabView {
                    
                    TodoListView(userId : viewModel.currentUserId)
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.circle")
                        }
                    
                }
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
