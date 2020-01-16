//
//  TaskListTableViewController.swift
//  mySimpleTask
//
//  Created by Uzo on 1/14/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.sharedGlobalInstance.fetchedResultsController.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.sharedGlobalInstance.fetchedResultsController.sections?.count ?? 0
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedGlobalInstance.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskListButtonTableViewCell else { return UITableViewCell() }
        let task = TaskController.sharedGlobalInstance.fetchedResultsController.object(at: indexPath)
        
        cell.updateCell(withTask: task)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.sharedGlobalInstance.fetchedResultsController.object(at: indexPath)
            
            TaskController.sharedGlobalInstance.delete(task: task)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayTaskDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? TaskDetailTableViewController else { return }
            
            let task = TaskController.sharedGlobalInstance.fetchedResultsController.object(at: indexPath)
            destination.task = task
        }
    }
    
}

extension TaskListTableViewController: TaskListButtonTableViewCellDelegate {
    func taskIsCompleteButtonWasTapped(_ sender: TaskListButtonTableViewCell) {
        /// get the indexPath of the sender; that is the the cell that was tapped
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        /// use that index to get the Task
        let task = TaskController.sharedGlobalInstance.fetchedResultsController.object(at: indexPath)
        
        /// use the model controller to handle the isComplete attribute of the Task
        TaskController.sharedGlobalInstance.toggleIsCompleteFor(task: task)
        
        /// update the cell
        sender.updateCell(withTask: task)
    }
}


extension TaskListTableViewController: NSFetchedResultsControllerDelegate {
    
    //conform to NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .delete:
                guard let indexPath = indexPath else {break}
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .insert:
                guard let newIndexPath = newIndexPath else { break }
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            case .move:
                guard let indexPath = indexPath, let newIndexPath = newIndexPath else { break }
                tableView.moveRow(at: indexPath, to: newIndexPath)
            case .update:
                guard let indexPath = indexPath else { break }
                tableView.reloadRows(at: [indexPath], with: .automatic)

            @unknown default:
                fatalError()
        }
    }
    
    //additional behavior for cells
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {

        switch type {
            case .insert:
                tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            case .move:
                break
            case .update:
                break
            @unknown default:
                fatalError()
        }
    }
}
