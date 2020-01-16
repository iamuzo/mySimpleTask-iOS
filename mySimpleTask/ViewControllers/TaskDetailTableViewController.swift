//
//  TaskDetailTableViewController.swift
//  mySimpleTask
//
//  Created by Uzo on 1/14/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    //MARK: Propertis
    var task: Task?
    var dateDue: Date?
    
    //MARK:- Outlets
    @IBOutlet var taskDatePicker: UIDatePicker!
    @IBOutlet weak var taskNotedTextView: UITextView!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDueDateTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDueDateTextField.inputView = taskDatePicker
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
        customizeButtons()
        tableView.reloadData()
    }

    
    //MARK:- Actions

    

   

    //MARK: Custom Methods
    func updateViews() {
        guard let task = task else {return}
        taskNameTextField.text = task.name
        taskNameTextField.isEnabled = false
        taskNotedTextView.text = task.notes
        taskNotedTextView.isEditable = false
        taskDueDateTextField.text = task.due?.stringValue()
        taskDueDateTextField.isEnabled = false
    }
    
    func customizeButtons(){
        if task != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTaskButtonTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTaskButtonTapped))
        }
    }
    
    @objc func editTaskButtonTapped() {
        print("Edit Mode")
        taskNameTextField.isEnabled = true
        taskNotedTextView.isEditable = true
        taskDueDateTextField.isEnabled = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateTaskButtonTapped))
        
    }
    
    @objc func saveTaskButtonTapped() {
        print("Save Task Button Tapped; used to create a new Task")
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else { return }
        guard let taskNote = taskNotedTextView.text, !taskNote.isEmpty else { return }
        let taskDueDate = taskDatePicker.date
        TaskController.sharedGlobalInstance.add(taskWithName: taskName, notes: taskNote, due: taskDueDate)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func updateTaskButtonTapped() {
        print("Update Task Button Tapped")
    }
}
