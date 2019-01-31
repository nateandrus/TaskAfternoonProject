//
//  DateHelpers.swift
//  TaskAfternoonProject
//
//  Created by Nathan Andrus on 1/30/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import Foundation

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
    }
    
}
