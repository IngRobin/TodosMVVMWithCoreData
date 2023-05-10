//
//  TodosMVVMWithCoreDataTests.swift
//  TodosMVVMWithCoreDataTests
//
//  Created by Robinson Gonzalez on 14/04/23.
//

import XCTest
@testable import TodosMVVMWithCoreData
import CoreData

final class TodosMVVMWithCoreDataTests: XCTestCase {
    
    var persistentStore: PersistentStore!
    var todosDatasource: TodosDatasourceProtocol!
    var todoObjects: [TodoObject] = []
    
    override func setUp() {
        //        super.setUp()
        persistentStore = PersistentStore()
        todosDatasource = TodosDatasource(persistentStore: persistentStore)
    }
 
    func test_Create_Todo(){
        DispatchQueue.main.async {
            Task{
                do{
                    let result = try await self.todosDatasource.createTodo(todo: TodoObject(id: UUID(), name: "todo test", date: Date()))
                    XCTAssertEqual(result, true)
                }catch{
                    fatalError("Error")
                }
            }
        }
    }
    
    func test_Update_Todo() throws{
        DispatchQueue.main.async {
            Task{
                var todoObject =  TodoObject(id: UUID(), name: "todo test", date: Date())
                _ = try await self.todosDatasource.createTodo(todo: todoObject)
                todoObject.name = "todo test updated"
                let result = try await self.todosDatasource.updateTodo(todo: todoObject)
                XCTAssertEqual(result, true)
            }
        }
    }
    
    override func tearDownWithError() throws {
        persistentStore = nil
        todosDatasource = nil
        todoObjects = []
    }
    
}
