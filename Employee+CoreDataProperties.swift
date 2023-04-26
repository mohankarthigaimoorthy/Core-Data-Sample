//
//  Employee+CoreDataProperties.swift
//  dataMining
//
//  Created by Mohan K on 10/03/23.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var empid: Int16
    @NSManaged public var empname: String?
    @NSManaged public var empsalary: Int16
    @NSManaged public var empposition: String?
    @NSManaged public var empage: Int16

}

extension Employee : Identifiable {

}
