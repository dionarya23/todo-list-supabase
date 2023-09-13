//
//  Todo.swift
//  TodoList
//
//  Created by Dion Arya Pamungkas on 13/09/23.
//

import Foundation

struct Todo: Codable, Identifiable, Hashable {
    var id: Int?
    var createdAt: Date
    var task: String
    var status: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, task, status
        case createdAt = "created_at"
    }
}
