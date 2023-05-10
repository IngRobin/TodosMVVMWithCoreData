//
//  TestCoreDataStack.swift
//  TodosMVVMWithCoreDataTests
//
//  Created by Robinson Gonzalez on 10/05/23.
//

import Foundation
import CoreData

class TestCoreDataStack: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: "TodosModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
