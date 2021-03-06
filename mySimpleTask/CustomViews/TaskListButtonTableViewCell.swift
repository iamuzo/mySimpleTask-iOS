//
//  TaskListButtonTableViewCell.swift
//  mySimpleTask
//
//  Created by Uzo on 1/14/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

protocol TaskListButtonTableViewCellDelegate: class {
    func taskIsCompleteButtonWasTapped(_ sender: TaskListButtonTableViewCell)
}

class TaskListButtonTableViewCell: UITableViewCell {
    
    var delegate: TaskListButtonTableViewCellDelegate?
    
    //MARK:- Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDueDateLabel: UILabel!
    @IBOutlet weak var taskIsCompleteButton: UIButton!
    
    //MARK: Actions
    @IBAction func taskIsCompleteButttonTapped(_ sender: UIButton) {
        /// when this button is tapped, we call on the delegate to perform an action
        /// in this call we want to toggle (that is switch the isComplete attribute)
        delegate?.taskIsCompleteButtonWasTapped(self)
    }
    
    //MARK:- Custom Methods
    fileprivate func updateTaskIsCompleteButton(_ isComplete: Bool) {
        let imageName = isComplete ? "complete" : "incomplete"
        taskIsCompleteButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    func updateCell(withTask task: Task?) {
        guard let existingTask = task else { return }
        taskNameLabel.text = existingTask.name
        if existingTask.due != nil {
            taskDueDateLabel.text = "Task is due on: \(existingTask.due!.stringValue())"
        } else {
            taskDueDateLabel.text = "Task has no due date"
        }
        updateTaskIsCompleteButton(existingTask.isComplete)
    }
}

