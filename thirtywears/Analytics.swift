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
    
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "type == %@", "Dress")) var dresses: FetchedResults<Clothing>
    
    
    var countOfItems: Int {
        getCount(threshold: settings.settingsThreshold)
     }

    
    var body: some View {
        
        NavigationView{
            List{
                Section(header: Text("Sustainable Items: \(countOfItems)"), footer: Text("Total Items: \(clothing.count)")) {
                ForEach(settings.items, id: \.self) {
                    let text = getTypeCount(threshold: settings.settingsThreshold, itemType: $0)
                    let total = getTotalType(itemType: $0)
                  Text("\($0): \(text) of \(total)")
                
                }
                }
                Section(header: Text("Cost per Wear")) {
                    
                    Text("Dresses: \(getAvCPW(wears: dresses.map { Int($0.wears) }, costs: dresses.map { Int($0.cost) }))")
                }
            }
            }
        }
    }
    
func getAvCPW(wears: [Int], costs: [Int]) -> Int {
//    let sortedArray = {
//    switch (wears, costs) {
//    case(0, 0): return 0
//    case(0, _): return costs / wears
//    case(_, _): return costs / wears
//    case(_, 0): return 0
//    }
//    }
//    return sortedArray.reduce(0,+) / sortedArray.count
    
//    let mergedArray = Dictionary(uniqueKeysWithValues: zip(wears, costs))
//    let mergedArrayNoNil = mergedArray.filter { $0.value != 0 }.mapValues { $0 }
//    let wears = mergedArrayNoNil.map { $0.0 }
//    let costs = mergedArrayNoNil.map { $0.1 }
    return costs.reduce(0,+) / wears.reduce(0,+)
}
    
    struct Analytics_Previews: PreviewProvider{
        static var previews: some View {
            Analytics()
                .environmentObject(Settings())
        }
    }


