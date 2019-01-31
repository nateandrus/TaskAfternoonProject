//
//  CoreDataStack.swift
//  TaskAfternoonProject
//
//  Created by Nathan Andrus on 1/30/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskAfternoonProject")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error) , \(error.userInfo)")
            }
        }
        return container
    }()
    static var context: NSManagedObjectContext{ return container.viewContext}
}
