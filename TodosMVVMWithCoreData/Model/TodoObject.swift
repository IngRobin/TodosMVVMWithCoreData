//
//  TodoObject.swift
//  TodosMVVMWithCoreData
//
//  Created by Robinson Gonzalez on 14/04/23.
//

import Foundation

struct TodoObject: Identifiable, Hashable {
    var id: UUID
    var name: String
    var date: Date
    
    init(id: UUID, name: String, date: Date) {
        self.id = id
        self.name = name
        self.date = date
    }
}

extension TodoObject{
    init(todoMO: TodoMO){
        self.id = todoMO.id!
        self.name = todoMO.name ?? ""
        self.date = todoMO.date ?? Date()
    }
}

extension TodoObject{
    init(){
        self.id = UUID()
        self.name = ""
        self.date = Date()
    }
}
