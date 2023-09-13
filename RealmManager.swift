//
//  RealmManager.swift
//  TodoList
//
//  Created by Dion Arya Pamungkas on 13/09/23.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    
    func openRealm() {
        do {
            let config = Realm.defaultConfiguration(schemaVersion: 1)
            
            
        } catch {
            print("Error opening Realm : \(error)")
        }
    }
}
