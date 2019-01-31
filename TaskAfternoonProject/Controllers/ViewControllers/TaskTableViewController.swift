//
//  TaskTableViewController.swift
//  TaskAfternoonProject
//
//  Created by Nathan Andrus on 1/30/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit
import CoreData

class TaskTableViewController: UITableViewController, ButtonTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.fetchedResultsController.object(at: index)
        TaskController.shared.toggleIsCompleteFor(task: task)
        sender.update(withTask: task)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.shared.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
                    as? ButtonTableViewCell else { return UITableViewCell() }
                let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
                cell.update(withTask: task)
                cell.delegate = self
                return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            TaskController.shared.remove(task: task)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TaskController.shared.fetchedResultsController.sectionIndexTitles[section] == "0" ? "Incomplete" : "Complete"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let index = tableView.indexPathForSelectedRow else {return}
//                let task = TaskController.shared.fetchedResultsController
                    let destinationVC = segue.destination as? DetailTaskTableViewController
                        destinationVC?.task = TaskController.shared.fetchedResultsController.object(at: index)
//                        destinationVC?.dueDateValue = TaskController.shared.fetchedResultsController.object(at: index).due
        }
    }
}

extension TaskTableViewController: NSFetchedResultsControllerDelegate {
        
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
        
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
        
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let newIndexPath = newIndexPath, let indexPath = indexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default: return
        }
    }
}

















//    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
//        guard let index = tableView.indexPath(for: sender) else { return }
//            let task = TaskController.shared.tasks[index.row]
//            TaskController.shared.toggleIsCompleteFor(task: task)
//            tableView.reloadRows(at: [index], with: .automatic)
//    }
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tableView.reloadData()
//    }
//
//
//
//    // MARK: - Table view data source
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return TaskController.shared.tasks.count
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
//            as? ButtonTableViewCell else { return UITableViewCell() }
//        let task = TaskController.shared.tasks[indexPath.row]
//        cell.update(withTask: task)
//        cell.delegate = self
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let task = TaskController.shared.tasks[indexPath.row]
//            TaskController.shared.remove(task: task)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//
//    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toDetailVC" {
//            guard let index = tableView.indexPathForSelectedRow else {return}
//                let task = TaskController.shared.tasks[index.row]
//                    let destinationVC = segue.destination as? DetailTaskTableViewController
//                        destinationVC?.task = task
//                        destinationVC?.dueDateValue = task.due as? Date
//        }
//    }
//}

