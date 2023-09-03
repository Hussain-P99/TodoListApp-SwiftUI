//
//  Todo_ListApp.swift
//  Todo List
//
//  Created by Hussain on 01/09/23.
//

import FirebaseCore
import SwiftUI

@main
struct Todo_ListApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
