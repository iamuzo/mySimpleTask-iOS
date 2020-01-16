//
//  TaskListTableViewController.swift
//  mySimpleTask
//
//  Created by Uzo on 1/14/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedGlobalInstance.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskListButtonTableViewCell else { return UITableViewCell() }
        
        let task = TaskController.sharedGlobalInstance.tasks[indexPath.row]
        
        cell.updateCell(withTask: task)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.sharedGlobalInstance.tasks[indexPath.row]
            
            TaskController.sharedGlobalInstance.delete(task: task)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "displayTaskDetail" {
            //idndex
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? TaskDetailTableViewController else { return }
            
            let task = TaskController.sharedGlobalInstance.tasks[indexPath.row]
            destination.task = task
        }
    }
    
}
