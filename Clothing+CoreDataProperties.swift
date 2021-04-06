//
//  Clothing+CoreDataProperties.swift
//  thirtywears
//
//  Created by Penelope Labram on 6/4/21.
//
//

import Foundation
import CoreData


extension Clothing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clothing> {
        return NSFetchRequest<Clothing>(entityName: "Clothing")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var wears: Int16
    @NSManaged public var type: String
    @NSManaged public var image: Data

}

extension Clothing : Identifiable {

}
