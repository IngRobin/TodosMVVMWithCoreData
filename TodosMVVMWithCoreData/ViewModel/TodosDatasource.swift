//
//  TodosDatasource.swift
//  TodosMVVMWithCoreData
//
//  Created by Robinson Gonzalez on 14/04/23.
//

import Foundation
import CoreData

protocol TodosDatasourceProtocol {
    
    func fetchTodos() async throws -> [NSManagedObject]
    func createTodo(todo: TodoObject) async throws -> Bool
    func deleteTodo(todo: TodoObject) async throws -> Bool
    func updateTodo(todo: TodoObject) async throws -> Bool
}

final class TodosDatasource: TodosDatasourceProtocol {

    let persistentStore: PersistentStore
    
    init(persistentStore: PersistentStore = PersistentStore()) {
        self.persistentStore = persistentStore
    }
    
    func fetchTodos() async throws -> [NSManagedObject]{
        let todosFR = TodoMO.self.fetchRequest()
        do{
            return try persistentStore.managedContext.fetch(todosFR)
        }catch let error{
            throw CoreDataError.fetchError(error)
        }
    }
    
    func createTodo(todo: TodoObject) async throws -> Bool {
        let todoMO = TodoMO(context: persistentStore.managedContext)
        todoMO.id = todo.id
        todoMO.name = todo.name
        todoMO.date = todo.date
        return try await saveData()
    }
    
    func deleteTodo(todo: TodoObject) async throws -> Bool{
        guard let todoMo = try fetchFirstObject(todo: todo) else{
            return false
        }
        self.persistentStore.managedContext.delete(todoMo)
        return try await saveData()
    }
    
    func updateTodo(todo: TodoObject) async throws -> Bool {
        guard let todoMo = try fetchFirstObject(todo: todo) else{
            return false
        }
        update(nsManagedObject: todoMo, todo: todo)
        return try await saveData()
    }

    private func saveData() async throws -> Bool{
        if persistentStore.managedContext.hasChanges {
            do {
                try persistentStore.managedContext.save()
                return true
            } catch {
                throw CoreDataError.saveDataError(error)
            }
        }else{
            return false
        }
    }
    
    private func fetchFirstObject(todo: TodoObject) throws -> TodoMO?{
        let fetchRequest = TodoMO.self.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", todo.id as CVarArg)
        fetchRequest.fetchLimit = 1
        do{
            let todoResult = try persistentStore.managedContext.fetch(fetchRequest)
            return todoResult.first ?? nil
        }catch let error{
            throw CoreDataError.fetchError(error)
        }
    }
    
    private func update (nsManagedObject: TodoMO, todo: TodoObject){
        nsManagedObject.name = todo.name
        nsManagedObject.date = todo.date
    }

    
//    func fetchTodos<T: NSManagedObject>(completionHandler: @escaping (Result<[T]?, CoreDataError>) -> ()){
//
////        let todosFR = NSFetchRequest<T>(entityName: "TodoMO")
//        let todosFR = TodoMO.self.fetchRequest()
//        do {
//            let todos = try persistentStore.managedContext.fetch(todosFR) as! [T]
//            completionHandler(.success(todos))
//        } catch let error {
//            completionHandler(.failure(.fetchError(error)))
//        }
//    }
//
//    func createTodo(todo: TodoObject, completionHandler: @escaping (Result<Bool, CoreDataError>) -> ()){
//        let todoMO = TodoMO(context: persistentStore.managedContext)
//        todoMO.id = todo.id
//        todoMO.name = todo.name
//        todoMO.date = todo.date
//        saveData(completionHandler: completionHandler)
//
//    }
//
//    func deleteTodo(todo: TodoObject, completionHandler: @escaping (Result<Bool, CoreDataError>) -> ()){
//        fetchFirstObject(todo: todo) { result in
//            switch result {
//            case .failure(let error):
//                completionHandler(.failure(error))
//            case .success(let todoDelete):
//                if let todoDelete = todoDelete{
//                    self.persistentStore.managedContext.delete(todoDelete)
//                    self.saveData(completionHandler: completionHandler)
//                } else{
//                    completionHandler(.failure(.corruptedDataError))
//                }
//
//
//            }
//        }
//    }
//
//    func updateTodo(todo: TodoObject, completionHandler: @escaping (Result<Bool, CoreDataError>) -> ()){
//        fetchFirstObject(todo: todo) { result in
//            switch result{
//            case .success(let managedObject):
//                self.update(nsManagedObject: managedObject as! TodoMO, todo: todo)
//                self.saveData(completionHandler: completionHandler)
//            case .failure(let error):
//                completionHandler(.failure(error))
//            }
//        }
//    }
//
//
//    private func saveData(completionHandler: @escaping (Result<Bool, CoreDataError>) -> ()){
//        if persistentStore.managedContext.hasChanges {
//            do {
//                try persistentStore.managedContext.save()
//                print("Data saved successfully")
//                completionHandler(.success(true))
//
//            } catch {
//                completionHandler(.failure(.saveDataError(error)))
//            }
//        }
//    }
//
//    private func fetchFirstObject<T: NSManagedObject>(todo: TodoObject, completionHandler: @escaping (Result<T?, CoreDataError>) -> ()){
////        let fetchRequest = NSFetchRequest<T>(entityName: "TodoMO")
//        let fetchRequest = TodoMO.self.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id = %@", todo.id as CVarArg)
//        fetchRequest.fetchLimit = 1
//        do {
//            let todoResult = try persistentStore.managedContext.fetch(fetchRequest) as! [T]
//            completionHandler(.success(todoResult.first))
//        } catch let error {
//            completionHandler(.failure(.fetchFirstError(error)))
//        }
//    }
}
