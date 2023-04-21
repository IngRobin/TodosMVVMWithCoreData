//
//  TodosCreateView.swift
//  TodosMVVMWithCoreData
//
//  Created by Robinson Gonzalez on 19/04/23.
//

import SwiftUI

struct TodosCreateView: View {
    
    @EnvironmentObject var todosViewModel: TodosViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var todo = TodoObject()
    
    var body: some View {
        VStack{
            
            VStack{
                Text("Nombre")
                TextField("Nombre", text: $todo.name)
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            
            Button {
                todosViewModel.createTodo(todo: todo)
                dismiss()
            } label: {
                Text("Crear")
            }
            

        }
    }
}

struct TodosCreateView_Previews: PreviewProvider {
    static var previews: some View {
        TodosCreateView()
    }
}
