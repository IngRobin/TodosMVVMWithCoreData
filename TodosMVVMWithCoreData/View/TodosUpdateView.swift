//
//  TodosUpdateView.swift
//  TodosMVVMWithCoreData
//
//  Created by Robinson Gonzalez on 19/04/23.
//

import SwiftUI

struct TodosUpdateView: View {
    
    @State var todo: TodoObject
    @EnvironmentObject var todosViewModel: TodosViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            VStack{
                Text("Nombre")
                    .foregroundColor(Color.black)
                
                TextField("Nombre", text: $todo.name)
                    .frame(maxHeight: 45)
                    .border(Color.gray, width: 0.5)
                    .padding([.horizontal, .bottom, .top], 30)
            }
            Button {
                todosViewModel.updateTodo(todo: todo)
                dismiss()
            } label: {
                Text("Actualizar")
            }
            Spacer()
        }
    }
    
    
}

struct TodosUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        TodosUpdateView(todo: TodoObject(id: UUID(), name: "Todo", date: Date()))
    }
}
