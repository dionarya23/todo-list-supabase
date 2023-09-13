//
//  TaskRow.swift
//  TodoList
//
//  Created by Dion Arya Pamungkas on 13/09/23.
//

import SwiftUI

struct TaskRow: View {
    var task: String
    var completed: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: completed ? "checkmark.circle" : "circle")
            
            Text(task)
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: "Cuci Piring", completed: true)
    }
}
