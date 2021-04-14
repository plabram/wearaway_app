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
    @NSManaged public var cost: Int16
    @NSManaged public var type: String
    @NSManaged public var image: Data
    
    
    public var costPerWear: String {
        get {
            if (self.cost > 0 && self.wears > 0) {
                let calcValue = cost / wears
                let newValue = String("\(calcValue) € per wear")
                return newValue
            }
            else if (self.cost > 0 && self.wears == 0) {
                return String("Cost: \(self.cost) €")
            }
            else {
                return "Add cost"
            }
        }
        set {
            self.costPerWear = newValue
        }
    }

}

extension Clothing : Identifiable {

}

func getCount(threshold: Int) -> Int {
   var countOfItems: Int = 0
   let context = PersistenceController.shared.container.viewContext

   let clothingFetchRequest: NSFetchRequest<Clothing> = Clothing.fetchRequest()

   clothingFetchRequest.predicate = NSPredicate(format: "wears >= %d", threshold)

   do {
      countOfItems = try context.count(for: clothingFetchRequest)
      print (countOfItems)
   }
   catch {
      print (error)
   }
   return countOfItems
}


func getTypeCount(threshold: Int, itemType: String) -> Int {
   var countOfItems: Int = 0
   let context = PersistenceController.shared.container.viewContext

   let clothingFetchRequest: NSFetchRequest<Clothing> = Clothing.fetchRequest()

   clothingFetchRequest.predicate = NSPredicate(format: "wears >= %d AND type == %@", threshold, "\(itemType)")

   do {
      countOfItems = try context.count(for: clothingFetchRequest)
      print (countOfItems)
   }
   catch {
      print (error)
   }
   return countOfItems
}

func getTotalType(itemType: String) -> Int {
   var countOfItems: Int = 0
   let context = PersistenceController.shared.container.viewContext

   let clothingFetchRequest: NSFetchRequest<Clothing> = Clothing.fetchRequest()

   clothingFetchRequest.predicate = NSPredicate(format: "type == %@", "\(itemType)")

   do {
      countOfItems = try context.count(for: clothingFetchRequest)
      print (countOfItems)
   }
   catch {
      print (error)
   }
   return countOfItems
}


