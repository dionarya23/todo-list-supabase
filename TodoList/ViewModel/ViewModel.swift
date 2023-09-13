//
//  ViewModel.swift
//  TodoList
//
//  Created by Dion Arya Pamungkas on 13/09/23.
//

import Foundation
import Supabase

enum Table {
    static let todo = "todos"
}

@MainActor
final class ViewModel: ObservableObject {
    @Published var todos = [Todo]()
    
    let supabase = SupabaseClient(supabaseURL: Secrets.projectURL, supabaseKey: Secrets.apiKey)
    
    func createTodoRequest(task: String) async throws {
                let todo = Todo(createdAt: Date(),task: task, status: false)

        try await supabase.database.from(Table.todo)
            .insert(values: todo)
            .execute()
        try await fetchTodoRequest()

    }
    
    func fetchTodoRequest() async throws {
    do {

        let todos: [Todo] = try await supabase.database
            .from(Table.todo)
            .select()
            .order(column: "created_at", ascending: false)
            .execute()
            .value
        
        DispatchQueue.main.async {
            self.todos = todos
        }
        } catch {
            print("❌ Error: \(error)")
        }
    }
    
    func updateTodoRequest(_ todo: Todo, status: Bool) async throws {
        guard let id = todo.id else {
            print("❌ Can't update feature \(String(describing: todo.id))")
            return
        }
        
        var toUpdate = todo
        toUpdate.status = status
        do {
            try await supabase.database
                .from(Table.todo)
                .update(values: toUpdate)
                .eq(column: "id", value: id)
                .execute()
            
            try await fetchTodoRequest()
        } catch {
            print("❌ Error: \(error)")
        }
    }
    
    func deleteTodo(id: Int) async throws {
            try await supabase.database
                .from(Table.todo)
                .delete()
                .eq(column: "id", value: id)
                .execute()
            try await fetchTodoRequest()
        }
    
}
