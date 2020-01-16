//
//  TaskController.swift
//  mySimpleTask
//
//  Created by Uzo on 1/14/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation
import CoreData

class TaskController {

    
    //MARK:- Shared Global Instance/Singleton
    static let sharedGlobalInstance = TaskController()
    
    //MARK:- Property
    /**
     Source of truth
     - Creates an array of Task Objects, which either contain
        - the results of a fetchRequest OR
        - an empty array
     - fetchRequest: We set our fetchRequest to be *of type* a `NSFetchRequest` that can interact with `Task` objects
     - returns: the results of our fetch request *or* an empty array
     */
    var tasks: [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    //MARK: CRUD
    func add(taskWithName name: String, notes: String, due: Date) {
        Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String, due: Date) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    func delete(task: Task) {
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    
    private func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object Context, item not saved")
        }
    }
}

