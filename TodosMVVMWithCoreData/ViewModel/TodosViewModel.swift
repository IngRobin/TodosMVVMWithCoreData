//
//  TodosViewModel.swift
//  TodosMVVMWithCoreData
//
//  Created by Robinson Gonzalez on 14/04/23.
//

import Foundation
import CoreData

final class TodosViewModel: ObservableObject {
    
    @Published var todos:  [TodoObject] = []
    @Published var message: String?
    @Published var alertType: AlertType? = nil
    @Published var alertError: Bool = false
    
    let todosRepository: TodosRepositoryProtocol
    
    init(todosRepository: TodosRepositoryProtocol = TodosRepository()) {
        self.todosRepository = todosRepository
    }
    
    func fetchTodos(){
        DispatchQueue.main.async {
            Task{
                do{
                    let todosMO = try await self.todosRepository.fetchTodos()
                    self.todos = todosMO.map{
                        TodoObject(todoMO: $0 as! TodoMO)
                    }
                }catch let error as CoreDataError{
                    self.message = error.errorDescription
                    self.alertError = true
                    self.alertType = .error
                }
            }
        }
    }
    
    func createTodo(todo: TodoObject){
        DispatchQueue.main.async {
            Task{
                do{
                    if try await self.todosRepository.createTodo(todo: todo){
                        self.message = "Operacion realizada"
                        self.alertError = true
                        self.alertType = .success
                    }else{
                        self.message = "Operacion no realizada"
                        self.alertError = true
                        self.alertType = .error
                    }
                }catch let error as CoreDataError {
                    self.message = error.errorDescription
                    self.alertError = true
                    self.alertType = .error
                }
            }
        }
    }
    
    func deleteTodo (at offsets: IndexSet){
        DispatchQueue.main.async {
            for index in offsets{
                Task{
                    do{
                        if try await self.todosRepository.deleteTodo(todo: self.todos[index]){
                            self.message = "Operacion realizada"
                            self.alertError = true
                            self.alertType = .success
                        }else{
                            self.message = "Operacion no realizada"
                            self.alertError = true
                            self.alertType = .error
                        }
                    }catch let error as CoreDataError{
                        self.message = error.errorDescription
                        self.alertError = true
                        self.alertType = .error
                    }
                }
            }
        }
    }
    
    func updateTodo(todo: TodoObject){
        DispatchQueue.main.async {
            Task{
                do{
                    if try await self.todosRepository.updateTodo(todo: todo){
                        self.message = "Operacion realizada"
                        self.alertError = true
                        self.alertType = .success
                    }else{
                        self.message = "Operacion no realizada"
                        self.alertError = true
                        self.alertType = .error
                    }
                }catch let error as CoreDataError {
                    self.message = error.errorDescription
                    self.alertError = true
                    self.alertType = .error
                }
            }
        }
    }
    
//    func fetchTodos(){
//        DispatchQueue.main.async {
//            self.todosRepository.fetchTodos {[weak self] result in
//                switch result {
//                case .success(let todosMO):
//                    self?.todos = todosMO!.map{
//                        TodoObject(todoMO: $0 as! TodoMO)
//                    }
//                case .failure(let error):
//                    self?.messageError = error.errorDescription
//                    self?.alertError = true
//                    self?.alertType = .error
//                }
//            }
//        }
//    }
//
//    func createTodo(todoObject: TodoObject){
//        DispatchQueue.main.async {
//            self.todosRepository.createTodo(todo: todoObject) {[weak self] result in
//                self?.switchResult(result: result)
//            }
//        }
//    }
//
//    func deleteTodo(at offsets: IndexSet){
//        DispatchQueue.main.async {
//            for index in offsets{
//                self.todosRepository.deleteTodo(todo: self.todos[index]) {[weak self] result in
//                    self?.switchResult(result: result)
//                }
//            }
//        }
//    }
//
//    func updateTodo(todo: TodoObject){
//        DispatchQueue.main.async {
//            self.todosRepository.updateTodo(todo: todo) {[weak self] result in
//                self?.switchResult(result: result)
//            }
//        }
//    }
//
//    private func switchResult(result: Result<Bool, CoreDataError>){
//        switch result {
//        case .success(_):
//            self.fetchTodos()
//            self.alertError = true
//            self.alertType = .success
//        case .failure(let error):
//            self.messageError = error.errorDescription
//            self.alertError = true
//            self.alertType = .error
//        }
//    }
    
}

