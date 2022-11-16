//
//  Person+CoreDataProperties.swift
//  CoreDataLesson
//
//  Created by Артем Галай on 16.11.22.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}

extension Person : Identifiable {

}
