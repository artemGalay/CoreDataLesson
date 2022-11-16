//
//  Person+CoreDataClass.swift
//  CoreDataLesson
//
//  Created by Артем Галай on 16.11.22.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Person"), insertInto: CoreDataManager.instance.context)

    }

}
