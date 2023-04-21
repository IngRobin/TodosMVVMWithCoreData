//
//  ContentView.swift
//  TodosMVVMWithCoreData
//
//  Created by Robinson Gonzalez on 14/04/23.
//

import SwiftUI

struct TodosView: View {
    
    @EnvironmentObject var todosViewModel : TodosViewModel
    
    var body: some View {
        NavigationView {
            List{
                ForEach(todosViewModel.todos, id: \.self) {
                    todo in
                    NavigationLink {
                        TodosUpdateView(todo: todo)
                    } label: {
                        Text("\(todo.name)")
                    }
                }.onDelete{ indexSet in
                    todosViewModel.deleteTodo(at: indexSet)
                    todosViewModel.fetchTodos()
                }
            }.onAppear{
                todosViewModel.fetchTodos()
            }.alert(isPresented: $todosViewModel.alertError) {
                getAlert(alertType: todosViewModel.alertType) {
                    todosViewModel.fetchTodos()
                }
            }.navigationTitle("Tareas")
            .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            NavigationLink(destination: TodosCreateView()) {
                                Image(systemName: "plus")
                                
                            }
                        }
                        
                    }
                    
                }
        }
    }
    
    //    func deleteItem(at offsets: IndexSet) {
    //        todosViewModel.deleteTodo(at: offsets)
    //    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            TodosView()
        }
    }
}
