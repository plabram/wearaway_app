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
                    
                    Text("Dresses: \(averageCostPerWear(wears: dresses.map { Int($0.wears) }, cost: dresses.map { Int($0.cost) }), specifier: "%.2f")")
                }
            }
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
print(wearsReduced)

    let costReduced = cost
    .enumerated()
    .filter { !found.contains($0.offset) }
    .map { $0.element }
print(costReduced)

    let averageCPW = Float(wearsReduced.reduce(0,+) / costReduced.reduce(0,+))
    
return averageCPW
}
    
    struct Analytics_Previews: PreviewProvider{
        static var previews: some View {
            Analytics()
                .environmentObject(Settings())
        }
    }


