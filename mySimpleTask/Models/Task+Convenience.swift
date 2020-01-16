//
//  Task+Convenience.swift
//  mySimpleTask
//
//  Created by Uzo on 1/14/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    /// `@discarableResult` indicates we have the option of ignoring the returned value from the initializer
    @discardableResult
    /**
     Initializes a Task object from a context

     - Parameters:
        - name: String value for the name attribute
        - notes Optional String value for the notes attribute, default value of nil
        - due: Optional date value for the due attribute, default value of nil
        - context: The NSManagedObjectContext for the app, default value set to the CoreDataStack class's context property
     */
    convenience init(name: String, notes: String? = nil, due: Date? = nil, isComplete: Bool = false,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        /** `self.init(context: context)` is a convenience initializer for the task format*/
        self.init(context: context)

        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = isComplete
    }
}
