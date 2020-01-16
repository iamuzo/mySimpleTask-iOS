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
    @IBOutlet weak var taskNoteTextView: UITextView!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDueDateTextField: UITextField!
    
    private var datePicker: UIDatePicker?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
        customizeButtons()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // handle a user dismissing the datePicker without
        // having made a selection
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(guestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        taskDueDateTextField.inputView = datePicker
        //taskDueDateTextField.inputView = taskDatePicker
        
        
        //tableView.reloadData()
        
    }
    
    //MARK:- Actions

    //MARK: Custom Methods
    func updateViews() {
        guard let task = task else {return}
        taskNameTextField.text = task.name
        taskNameTextField.isEnabled = false
        taskNoteTextView.text = task.notes
        taskNoteTextView.isEditable = false
        taskDueDateTextField.text = task.due?.stringValue()
        taskDueDateTextField.isEnabled = false
    }
    
    func customizeButtons() {
        if task != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTaskButtonTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTaskButtonTapped))
        }
    }
    
    @objc func viewTapped(guestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let userSelectedDate = datePicker.date
        taskDueDateTextField.text = dateFormatter.string(from: userSelectedDate)
    }
    
    
    @objc func editTaskButtonTapped() {
        print("Edit Mode")
        taskNameTextField.isEnabled = true
        taskNoteTextView.isEditable = true
        taskDueDateTextField.isEnabled = true
        let updateBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(updateTaskButtonTapped))
        let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelUpdateButtonTapped))
        navigationItem.rightBarButtonItems = [cancelBarButtonItem, updateBarButtonItem]
    }
    
    @objc func cancelUpdateButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveTaskButtonTapped() {
        print("Save Task Button Tapped; used to create a new Task")
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else { return }
        guard let taskNote = taskNoteTextView.text, !taskNote.isEmpty else { return }
        let taskDueDate = taskDatePicker.date
        TaskController.sharedGlobalInstance.add(taskWithName: taskName, notes: taskNote, due: taskDueDate)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func updateTaskButtonTapped() {
        print("Update Task Button Tapped")
        guard let existingTask = task else { return }
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else { return }
        guard let taskNote = taskNoteTextView.text, !taskNote.isEmpty else { return }
        guard let taskDueDateAsString = taskDueDateTextField.text, !taskDueDateAsString.isEmpty else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        guard let taskDueDate = formatter.date(from: taskDueDateAsString) else { return }
        
        TaskController.sharedGlobalInstance.update(task: existingTask, name: taskName, notes: taskNote, due: taskDueDate)
        navigationController?.popViewController(animated: true)
    }
}
