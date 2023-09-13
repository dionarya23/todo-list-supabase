//
//  ContentView.swift
//  TodoList
//
//  Created by Dion Arya Pamungkas on 13/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var showAddTaskView = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TaskView(viewModel: viewModel)
            
            SmallAddButton()
                .padding()
                .onTapGesture {
                    showAddTaskView.toggle()
                }
        }
        .sheet(isPresented: $showAddTaskView) {
            AddTaskView(viewModel: viewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
        .onAppear() {
            Task {
                do {
                    try await viewModel.fetchTodoRequest()
                } catch {
                    print("❌ Error fetching todos: \(error)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
