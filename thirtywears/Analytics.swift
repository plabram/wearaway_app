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
    
    
//    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [])
//    var clothing: FetchedResults<Clothing>
    
    var body: some View {
        
        NavigationView{
            List{
                Section(header: Text("Sustainable Items")) {
                ForEach(settings.items, id: \.self) {
                    let text = getTypeCount(threshold: settings.settingsThreshold, itemType: $0)
                    let total = getTotalType(itemType: $0)
                  Text("\($0): \(text) of \(total)")
                    
                }
                }
            }
        }
    }
    
    
    
    struct Analytics_Previews: PreviewProvider{
        static var previews: some View {
            Analytics()
                .environmentObject(Settings())
        }
    }
}

