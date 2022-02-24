//
//  Todo+CoreDataProperties.swift
//  Todo List
//
//  Created by Võ Trí on 24/02/2022.
//
//

import Foundation
import CoreData


extension TodoCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var name: String?
    @NSManaged public var status: Bool

}

extension TodoCoreData : Identifiable {

}
