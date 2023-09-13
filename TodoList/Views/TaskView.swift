//
//  TaskView.swift
//  TodoList
//
//  Created by Dion Arya Pamungkas on 13/09/23.
//

import SwiftUI

struct TaskView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Text("My Tasks")
                .font(.title3).bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            List {
                ForEach(viewModel.todos, id: \.id) {
                    task in
                    TaskRow(task: task.task, completed: task.status)
                        .onTapGesture {
                            Task {
                                try await viewModel.updateTodoRequest(task, status: !task.status)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                Task {
                                    try await viewModel.deleteTodo(id: task.id ?? 0)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                .listRowSeparator(.hidden)
            }
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableView.appearance()
                    .backgroundColor = UIColor.clear
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(viewModel: ViewModel())
    }
}
