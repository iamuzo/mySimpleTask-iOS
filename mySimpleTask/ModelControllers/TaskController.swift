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
    var fetchedResultsController: NSFetchedResultsController<Task>
    
    init(){
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true)]
        
        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "Complete", cacheName: nil)
        fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("there was an error performing the fetch. \(error.localizedDescription)")
        }
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

