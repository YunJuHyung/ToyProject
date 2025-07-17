//
//  main.swift
//  RealmPracitce
//
//  Created by 윤주형 on 9/5/24.
//

import Foundation
import RealmSwift

class Todo: Object {
   @Persisted(primaryKey: true) var _id: ObjectId
   @Persisted var name: String = ""
   @Persisted var status: String = ""
   @Persisted var ownerId: String

   convenience init(name: String, ownerId: String) {
       self.init()
       self.name = name
       self.ownerId = ownerId
   }
}


// Open the local-only default realm
let realm = try! Realm()


let todo = Todo(name: "Do laundry", ownerId: "qwe")
try! realm.write {
    realm.add(todo)
}

// Get all todos in the realm
let todos = realm.objects(Todo.self)

print(todos)
