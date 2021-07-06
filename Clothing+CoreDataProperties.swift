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

    @NSManaged public var id: UUID
    @NSManaged public var wears: Int16
    @NSManaged public var cost: Double
    @NSManaged public var type: String
    @NSManaged public var image: Data
    
//    var wrappedType: String {
//        type ?? "Unknown"
//    }
    
    
    public var costPerWear: String {
        get {
            if (self.cost > 0 && self.wears > 0) {
                let calcValue = cost / Double(wears)
                let newValueRaw = String(format: "%.2f", calcValue)
                let newValue = String("\(newValueRaw) € per wear")
                return newValue
            }
            else if (self.cost > 0 && self.wears == 0) {
                let costString = String(format: "%.2f", cost)
                return String("Cost: \(costString) €")
            }
            else {
                return "No cost added"
            }
        }
        set {
            self.costPerWear = newValue
        }
    }

}

extension Clothing : Identifiable {

}
