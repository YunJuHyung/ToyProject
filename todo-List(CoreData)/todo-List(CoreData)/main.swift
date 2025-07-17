//
//  main.swift
//  todo-List(CoreData)
//
//  Created by 윤주형 on 8/17/24.
//

import Foundation
import CoreData

let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Model") // 여기서 "Model"은 Core Data 모델 파일(.xcdatamodeld)의 이름입니다.
    
    container.loadPersistentStores { storeDescription, error in
        if let error = error as NSError? {
            //처음에 구축할떄 userInfo로 해서 그런지 error.todoList의 선택지가 안나옴
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    return container
}()

func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

struct TodoListValue {
    var name: String
    var list: String
    var uuid = UUID()
}

func savingEntities(name: String, list: String) {
    //일단 생일 스트링으로 함
    let juhyung = TodoListValue(name: name, list: list)
    
    let context = persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "TodoList", in: context)
    
    if let entity = entity {
        let person = NSManagedObject(entity: entity, insertInto: context)
        person.setValue(juhyung.name, forKey: "name")
        person.setValue(juhyung.list, forKey: "list")
        person.setValue(UUID(), forKey: "uuid")
        
        
        do{
            try context.save()
        } catch {
            print("저장 에러 \(error.localizedDescription)")
        }
    }
}

func fetchEntities(name: String){
    //fetchAllRequest
    let fetchAllRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
    let context = persistentContainer.viewContext
    fetchAllRequest.returnsObjectsAsFaults = false // Fault 해제 설정
    fetchAllRequest.predicate = NSPredicate(format: "name == %@", name)
    
    do {
        let fetchData = try context.fetch(fetchAllRequest) as [TodoList]
        if fetchData == [] {
            print("no member in UserList")
        } else {
            print(fetchData)
        }
    } catch {
        print(error.localizedDescription)
        
    }
}

func updateEntities(id: UUID , list: String) {
    
    let context = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoList")
    fetchRequest.predicate = NSPredicate(format: "uuid = %@", id.uuidString)
    
    do {
        guard let object = try? context.fetch(fetchRequest),
              let updatingResult = object.first as? NSManagedObject else { return }
        updatingResult.setValue(list, forKey: "list")
        
        try context.save()
    } catch {
        if fetchRequest.predicate == nil {
            print("nothing match fetchRequest")
        }
        print(error.localizedDescription)
    }
}

func deleteEntities(id: UUID) {
    
    let context = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoList")
    fetchRequest.predicate = NSPredicate(format: "uuid = %@", id.uuidString)
    
    do {
        let fetchedEntities = try context.fetch(fetchRequest)
        guard let result = fetchedEntities.first as? NSManagedObject else { return }
        context.delete(result)
        
        try context.save()
    } catch {
        print(error.localizedDescription)
    }
}

func userInputUUID() -> UUID{
    guard let userInputUUID = UUID(uuidString: readLine() ?? "") else { return UUID() }
    return userInputUUID
}

func fetchForViewName() {
    let fetchAllRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
    let context = persistentContainer.viewContext
    fetchAllRequest.returnsObjectsAsFaults = false // Fault 해제 설정
    
    do {
        let viewName = try context.fetch(fetchAllRequest)
        for index in viewName {
            if let name = index.value(forKey: "name") {
                print("저장된 이름(id) : \(name)")
            }
        }
    } catch {
        print(error.localizedDescription)
    }
    
    
    
}

func main() {
    var running: Bool = true
    
    fetchForViewName()
    print("이름 입력: ")
    let userInputName = String(readLine() ?? "")
    fetchEntities(name: userInputName)
    print(#fileID, #function, #line, "로그인 성공")
    
    while running {
        print("1.add-List 2.update-List 3.delete-List 4.log-out")
        let checkSelection = Int(readLine() ?? "")
        
        switch checkSelection {
        case 1:
            print("할일 입력: ")
            let userInputTodo = String(readLine() ?? "")
            savingEntities(name: userInputName, list: userInputTodo)
            fetchEntities(name: userInputName)
        case 2:
            print("할일 수정/ 수정할 목록의 uuid 입력 필요")
            print("uuid 입력: ")
            guard let userInputUUIDUpdate = UUID(uuidString: readLine() ?? "") else { return }
            print("수정할 할일 입력: ")
            let userInputTodoUpdate = String(readLine() ?? "")
            updateEntities(id: userInputUUIDUpdate, list: userInputTodoUpdate)
            fetchEntities(name: userInputName)
        case 3:
            print("할일 삭제")
            deleteEntities(id: userInputUUID())
            fetchEntities(name: userInputName)
        case 4:
            print("로그아웃 while 종료")
            running = false
        default :
            print("default mode")
        }
        print("while문 종료!!")
    }
}// main end

main()
