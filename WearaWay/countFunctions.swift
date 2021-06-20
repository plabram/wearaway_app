//
//  countFunctions.swift
//  WearaWay
//
//  Created by Penelope on 20/6/21.
//

import Foundation
import CoreData

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
