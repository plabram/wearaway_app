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

    var avCostPerWear: Int {
        if clothingWithCost.count > 0 {
        return clothingWithCost.map { Int($0.cost) }.reduce(0,+) / clothingWithCost.count / clothingWithCost.map { Int($0.wears) }.reduce(0,+)
        }
        else {return 0}
    }
    
    let banners = Bundle.main.decode("BannersData.json")
    
    init() {
         UITableView.appearance().backgroundColor = UIColor(Color.white)
      }

    var body: some View {
        
        NavigationView{
            VStack{
                
            BannerView(banner: banners[settings.currentBanner])
            
            List{
                
                Section(header: Text("Sustainable Items: \(countOfItems) of \(clothing.count)")) {
                ForEach(settings.items, id: \.self) {
                    let text = getTypeCount(threshold: settings.settingsThreshold, itemType: $0)
                    let total = getTotalType(itemType: $0)
                    Text("\($0.pluralNames()): \(text) of \(total)")
                
                }
                }
                Section(header: Text("Average cost per wear: \(avCostPerWear) €")) {
                    
                    
                    ForEach(andAv(clothes: group(clothingWithCost)), id: \.self) { i in
                        
                        Text("\(i)")
                    }
                    
                    
//                    ForEach(group(clothing), id: \.self) { i in
//                        Text("\(i.map { $0.type }.prefix(1).joined(separator: ",").pluralNames()): \((i.map { Int($0.cost) }.reduce(0,+)) / /*(i.map { Int($0.wears) }.reduce(0,+)) / */ (i.map { $0.id }.count)) € (\(i.map { $0.id }.count) items)")
//                               }
                }
                
                Section(header: Text("Never worn: \(clothingNeverWornWithCost.count + clothingNeverWorn.count) of \(clothing.count)")) {
                    ForEach(group(clothingNeverWornWithCost), id: \.self) { i in
                        Text("\(i.map { $0.type }.prefix(1).joined(separator: ",").pluralNames()): \(i.map { $0.id }.count) item(s) (\(i.map { Int($0.cost) }.reduce(0,+)) € )")
                               }
                    ForEach(group(clothingNeverWorn), id: \.self) {
                        i in
                        Text("\(i.map { $0.type }.prefix(1).joined(separator: ",").pluralNames()): \(i.map { $0.id }.count) item(s) (no cost specified)")
                               }
                }
            }
//            .listStyle(PlainListStyle())
            }
            .navigationTitle("Reports")
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


func group(_ result : FetchedResults<Clothing>)-> [[Clothing]] {
        
    return Dictionary(grouping: result) { $0.type }
            .sorted(by: {$0.key < $1.key})
            .map {$0.value}
        
    }

func andAv (clothes: [[Clothing]]) -> [String] {
    
    let averages: [String] = clothes.map { i in
        
        let sumCost = i.map { Int($0.cost) }.reduce(0,+)
        let sumWears = i.map { Int($0.wears) }.reduce(0,+)
        let itemCount = i.count
        let av = sumCost / (sumWears>0 ? sumWears : 1) / itemCount
        let type = i.map { $0.type }.prefix(1).joined(separator: ",").pluralNames()
        return String("\(type) : \(av)")
    }
    
    return averages
    
}

//func maxScore (clothes: [[Clothing]]) -> [Score] {
//    
//    let averages: [Score] = clothes.map { i in
//        
//        let sumCost = i.map { Int($0.cost) }.reduce(0,+)
//        let sumWears = i.map { Int($0.wears) }.reduce(0,+)
//        let itemCount = i.count
//        let av = sumCost / (sumWears>0 ? sumWears : 1) / itemCount
//        let type = i.map { $0.type }.prefix(1).joined(separator: ",").pluralNames()
//        return Score(type: type, avScore: av)
//    }
//    
//    return averages
//    
//}


struct Analytics_Previews: PreviewProvider {
    static var previews: some View {
        Analytics().environmentObject(Settings())
    }
}
