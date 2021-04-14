//
//  Analytics.swift
//  thirtywears
//
//  Created by Penelope Labram on 11/4/21.
//

import SwiftUI
import CoreData

struct Analytics: View {
    
    @EnvironmentObject var settings: Settings
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Clothing.type, ascending: true)]) var clothing: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Clothing.type, ascending: true)], predicate: NSPredicate(format: "cost !=0")) var clothingWithCost: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Clothing.type, ascending: true)], predicate: NSPredicate(format: "wears == 0 AND cost !=0")) var clothingNeverWornWithCost: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Clothing.type, ascending: true)], predicate: NSPredicate(format: "wears == 0 AND cost ==0")) var clothingNeverWorn: FetchedResults<Clothing>
    
    var countOfItems: Int {
        getCount(threshold: settings.settingsThreshold)
     }

    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Sustainable Items: \(countOfItems) of \(clothing.count)")) {
                ForEach(settings.items, id: \.self) {
                    let text = getTypeCount(threshold: settings.settingsThreshold, itemType: $0)
                    let total = getTotalType(itemType: $0)
                    Text("\($0.pluralNames()): \(text) of \(total)")
                
                }
                }
                Section(header: Text("Average cost per wear: \(clothingWithCost.map { Int($0.cost) }.reduce(0,+)/clothingWithCost.count) €")) {
                    ForEach(group(clothing), id: \.self) { i in
                        Text("\(i.map { $0.type }.prefix(1).joined(separator: ",").pluralNames()): \((i.map { Int($0.cost) }.reduce(0,+)) / (i.map { $0.id }.count)) € (\(i.map { $0.id }.count) items)")
                               }
                }
                
                Section(header: Text("Never worn: \(clothingNeverWornWithCost.count + clothingNeverWorn.count) of \(clothing.count)")) {
                    ForEach(group(clothingNeverWornWithCost), id: \.self) { i in
                        Text("\(i.map { $0.type }.prefix(1).joined(separator: ",").pluralNames()): \(i.map { $0.id }.count) item(s) (\(i.map { Int($0.cost) }.reduce(0,+)) € )")
                               }
                    ForEach(group(clothingNeverWorn), id: \.self) { i in
                        Text("\(i.map { $0.type }.prefix(1).joined(separator: ",").pluralNames()): \(i.map { $0.id }.count) item(s) (no cost specified)")
                               }
                }
            }
            }
        }
    }

extension String {
func pluralNames() -> String {
    if (self.suffix(2) == "ss") {
        return self + "es"
    }
    else if (self.suffix(1) == "s") {
        return self
    }
    else {
        return self + "s"
    }
}
}


//func averageCostPerWear(wears: [Int], cost: [Int]) -> Float {
//
//
//var found: [Int] = []
//
//for i in 0 ..< cost.count {
//    if cost[i] == 0 {
//        found.append(i)
//    }
//}
//
//    let wearsReduced = wears
//    .enumerated()
//    .filter { !found.contains($0.offset) }
//    .map { $0.element }
//
//    let costReduced = cost
//    .enumerated()
//    .filter { !found.contains($0.offset) }
//    .map { $0.element }
//
//    if (costReduced.reduce(0,+) > 0) {
//    let averageCPW = Float(
//        wearsReduced.reduce(0,+) /
//        costReduced.reduce(0,+)
//    )
//
//return averageCPW
//}
//    else {return 1}
//    }
//
//    struct Analytics_Previews: PreviewProvider{
//        static var previews: some View {
//            Analytics()
//                .environmentObject(Settings())
//        }
//    }

func group(_ result : FetchedResults<Clothing>)-> [[Clothing]] {
        
    return Dictionary(grouping: result) { $0.type }
            .sorted(by: {$0.key < $1.key})
            .map {$0.value}
        
    }
