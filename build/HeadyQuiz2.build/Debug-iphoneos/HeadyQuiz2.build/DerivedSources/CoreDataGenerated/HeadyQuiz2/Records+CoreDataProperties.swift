//
//  Records+CoreDataProperties.swift
//  
//
//  Created by Michael Wathen on 2/2/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Records {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Records> {
        return NSFetchRequest<Records>(entityName: "Records");
    }

    @NSManaged public var answer1: String?
    @NSManaged public var answer2: String?
    @NSManaged public var answer3: String?
    @NSManaged public var answer4: String?
    @NSManaged public var correctanswer: String?
    @NSManaged public var question: String?

}
