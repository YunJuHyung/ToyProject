//
//  UserInfo+CoreDataProperties.swift
//  todo-List(CoreData)
//
//  Created by 윤주형 on 8/18/24.
//
//

import Foundation
import CoreData


extension TodoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
        return NSFetchRequest<TodoList>(entityName: "TodoList")
    }
    //할일 목록
    @NSManaged public var name: String?
    @NSManaged public var list: String?
    @NSManaged public var uuid: UUID?
    
    

}

extension TodoList : Identifiable {

}


