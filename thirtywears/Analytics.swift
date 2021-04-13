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
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: []) var clothing: FetchedResults<Clothing>
    
//needs refactoring
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type == %@", "Dress")) var dresses: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type == %@", "Trousers")) var trousers: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type == %@", "Shoes")) var shoes: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type == %@", "Top")) var tops: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type == %@", "Skirt")) var skirts: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type == %@ AND wears == 0", "Dress")) var dressesNeverWorn: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type == %@ AND wears == 0", "Trousers")) var trousersNeverWorn: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type == %@ AND wears == 0", "Shoes")) var shoesNeverWorn: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type == %@ AND wears == 0", "Top")) var topsNeverWorn: FetchedResults<Clothing>
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type == %@ AND wears == 0", "Skirt")) var skirtsNeverWorn: FetchedResults<Clothing>
    
//end of refactoring
    
    var countOfItems: Int {
        getCount(threshold: settings.settingsThreshold)
     }

    
    var body: some View {
//needs refactoring
        let dressesAv = averageCostPerWear(wears: dresses.map { Int($0.wears) }, cost: dresses.map { Int($0.cost) })
        let trousersAv = averageCostPerWear(wears: trousers.map { Int($0.wears) }, cost: trousers.map { Int($0.cost) })
        let shoesAv = averageCostPerWear(wears: shoes.map { Int($0.wears) }, cost: shoes.map { Int($0.cost) })
        let topsAv = averageCostPerWear(wears: tops.map { Int($0.wears) }, cost: tops.map { Int($0.cost) })
        let skirtsAv = averageCostPerWear(wears: skirts.map { Int($0.wears) }, cost: skirts.map { Int($0.cost) })
        
        let dressesNeverWornCost = (dressesNeverWorn.map { Int($0.wears) }).reduce(0,+)
        let trousersNeverWornCost = (trousersNeverWorn.map { Int($0.wears) }).reduce(0,+)
        let shoesNeverWornCost = (shoesNeverWorn.map { Int($0.wears) }).reduce(0,+)
        let topsNeverWornCost = (topsNeverWorn.map { Int($0.wears) }).reduce(0,+)
        let skirtsNeverWornCost = (skirtsNeverWorn.map { Int($0.wears) }).reduce(0,+)
//end of refactoring
        
        NavigationView{
            List{
                Section(header: Text("Sustainable Items: \(countOfItems)"), footer: Text("Total Items: \(clothing.count)")) {
                ForEach(settings.items, id: \.self) {
                    let text = getTypeCount(threshold: settings.settingsThreshold, itemType: $0)
                    let total = getTotalType(itemType: $0)
                    Text("\($0.pluralNames()): \(text) of \(total)")
                
                }
                }
                Section(header: Text("Average cost per wear")) {
                    
//needs refactoring
                    Text("Dress: \(dressesAv, specifier: "%.2f") € (\(dresses.count) items)")
                    Text("Trousers: \(trousersAv, specifier: "%.2f") € (\(trousers.count) items)")
                    Text("Shoes: \(shoesAv, specifier: "%.2f") € (\(shoes.count) items)")
                    Text("Tops: \(topsAv, specifier: "%.2f") € (\(tops.count) items)")
                    Text("Skirts: \(skirtsAv, specifier: "%.2f") € (\(skirts.count) items)")
//end of refactoring
                }
                
                Section(header: Text("Never worn")) {
//needs refactoring
                    Text("Dresses: \(dressesNeverWorn.count) (\(dressesNeverWornCost) €)")
                    Text("Trousers: \(trousersNeverWorn.count) (\(trousersNeverWornCost) €)")
                    Text("Shoes: \(shoesNeverWorn.count) (\(shoesNeverWornCost) €)")
                    Text("Tops: \(topsNeverWorn.count) (\(topsNeverWornCost) €)")
                    Text("Skirts: \(skirtsNeverWorn.count) (\(skirtsNeverWornCost) €)")
                    
//end of refactoring
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


func averageCostPerWear(wears: [Int], cost: [Int]) -> Float {


var found: [Int] = []

for i in 0 ..< cost.count {
    if cost[i] == 0 {
        found.append(i)
    }
}

    let wearsReduced = wears
    .enumerated()
    .filter { !found.contains($0.offset) }
    .map { $0.element }

    let costReduced = cost
    .enumerated()
    .filter { !found.contains($0.offset) }
    .map { $0.element }

    if (costReduced.reduce(0,+) > 0) {
    let averageCPW = Float(
        wearsReduced.reduce(0,+) /
        costReduced.reduce(0,+)
    )
    
return averageCPW
}
    else {return 1}
    }
    
    struct Analytics_Previews: PreviewProvider{
        static var previews: some View {
            Analytics()
                .environmentObject(Settings())
        }
    }


//func group(_ result : FetchedResults<Clothing>)-> [[Clothing]] {
//        
//    return Dictionary(grouping: result) { $0.type }
//            .sorted(by: {$0.key < $1.key})
//            .map {$0.value}
//        
//    }
