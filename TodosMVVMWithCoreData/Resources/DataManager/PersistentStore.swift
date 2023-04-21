//
//  PersistentStore.swift
//  TodosMVVMWithCoreData
//
//  Created by Robinson Gonzalez on 14/04/23.
//

import Foundation
import CoreData

//protocol PersistentStoreProtocol {
//    func loadContainer() -> NSPersistentContainer
//    func getBackgroundContext(container: NSPersistentContainer) -> NSManagedObjectContext
//}


class PersistentStore {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodosModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading container \(error.localizedDescription)")
                fatalError("Error loading container \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var managedContext = persistentContainer.newBackgroundContext()
    
    
}
