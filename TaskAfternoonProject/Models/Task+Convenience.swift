//
//  Task+Convenience.swift
//  TaskAfternoonProject
//
//  Created by Nathan Andrus on 1/30/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    @discardableResult
    convenience init(name: String, notes: String? = nil, due: Date? = nil, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.due = Date()
        self.isComplete = isComplete
    }
}
