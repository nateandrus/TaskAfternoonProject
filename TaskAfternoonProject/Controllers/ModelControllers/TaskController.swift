//
//  TaskModelController.swift
//  TaskAfternoonProject
//
//  Created by Nathan Andrus on 1/30/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    let fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let isCompleteSort = NSSortDescriptor(key: "isComplete", ascending: false)
        let dueSort = NSSortDescriptor(key: "due", ascending: false)
        fetchRequest.sortDescriptors = [isCompleteSort, dueSort]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
    }()
    
    init() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error loading: \(error) : \(error.localizedDescription)")
        }
    }
    
    static let shared = TaskController()
    
//    var tasks: [Task]{
//        let request: NSFetchRequest<Task> = Task.fetchRequest()
//        return (try? CoreDataStack.context.fetch(request)) ?? []
//    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
        
    }
    
    func remove(task: Task) {
        if let moc = task.managedObjectContext {
            moc.delete(task)
            saveToPersistentStore()
        }
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving to persistent store: \(error) , \(error.localizedDescription)")
        }
    }
    
//    private func fetchTasks() -> [Task] {
//        let request: NSFetchRequest<Task> = Task.fetchRequest()
//        return (try? CoreDataStack.context.fetch(request)) ?? []
//    }
}


