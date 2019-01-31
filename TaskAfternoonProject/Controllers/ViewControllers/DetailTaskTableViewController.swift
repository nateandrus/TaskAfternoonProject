//
//  DetailTaskTableViewController.swift
//  TaskAfternoonProject
//
//  Created by Nathan Andrus on 1/30/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class DetailTaskTableViewController: UITableViewController {
    
    var task: Task? {
        didSet {
            loadViewIfNeeded()
            updateViews()
            dueDateValue = task?.due
        }
    }
    
    var dueDateValue: Date?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = datePicker
        updateViews()
    }
    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        dueDateTextField.text = sender.date.stringValue()
        dueDateValue = sender.date
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let nameText = nameTextField.text, nameText != "" else { return }
            let dueDate = dueDateValue
            let notes = notesTextView.text
        
        if let task = self.task {
            TaskController.shared.update(task: task, name: nameText, notes: notes, due: dueDate)
            self.navigationController?.popViewController(animated: true)
        } else {
            TaskController.shared.add(taskWithName: nameText, notes: notes, due: dueDate)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let task = task else { return }
        nameTextField.text = task.name
        dueDateTextField.text = task.due?.stringValue()
        notesTextView.text = task.notes
        self.title = task.name
    }
}
