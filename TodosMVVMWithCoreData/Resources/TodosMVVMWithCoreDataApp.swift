//
//  TodosMVVMWithCoreDataApp.swift
//  TodosMVVMWithCoreData
//
//  Created by Robinson Gonzalez on 14/04/23.
//

import SwiftUI

@main
struct TodosMVVMWithCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            TodosView().environmentObject(TodosViewModel())
        }
    }
}
