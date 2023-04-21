//
//  TodosRepository.swift
//  TodosMVVMWithCoreData
//
//  Created by Robinson Gonzalez on 14/04/23.
//

import Foundation
import CoreData

protocol TodosRepositoryProtocol {
    func fetchTodos() async throws -> [NSManagedObject]
    func createTodo(todo: TodoObject) async throws -> Bool
    func deleteTodo(todo: TodoObject) async throws -> Bool
    func updateTodo(todo: TodoObject) async throws -> Bool
}

final class TodosRepository: TodosRepositoryProtocol {
    
    let todoDatasource: TodosDatasourceProtocol
    
    init(todoDatasource: TodosDatasourceProtocol = TodosDatasource()){
        self.todoDatasource = todoDatasource
    }
    
    func fetchTodos() async throws -> [NSManagedObject]{
        try await todoDatasource.fetchTodos()
    }
    
    func createTodo(todo: TodoObject) async throws -> Bool{
        try await todoDatasource.createTodo(todo: todo)
    }
    
    func deleteTodo(todo: TodoObject) async throws -> Bool{
        try await todoDatasource.deleteTodo(todo: todo)
    }
    
    func updateTodo(todo: TodoObject) async throws -> Bool{
        try await todoDatasource.updateTodo(todo: todo)
    }
}
