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
    
    //MARK:- Shared Global Instance
    static let sharedGlobalInstance = TaskController()
    
    //MARK:- Mock Data
    var mockTasks: [Task] {
        return [
            Task(name: "Sample Task One", notes: "Notes for Sample Task 1", due: Date()),
            Task(name: "Sample Task Two", notes: "Notes for Sample Task 2", due: Date()),
            Task(name: "Sample Task Three", notes: "Notes for Sample Task 3", due: nil, isComplete: true)
        ]
        
    }
    
    //MARK:- Property
    var tasks: [Task] = []
    
    init() {
        tasks = mockTasks
    }
    
    //MARK:- CRUD
    func add(taskWithName name: String, notes: String?, due: Date?) {
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?){
    }
    
    func delete(task: Task) {
    }
    
    func saveToPersistentStore() {
    }
    
    func fetchTasks() -> [Task] {
        return []
    }
}
