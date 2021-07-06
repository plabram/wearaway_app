//
//  FilteredList.swift
//  WearaWay
//
//  Created by Penelope on 2/7/21.
//

//this is where users can modify an item of clothing. It's separated into two structs. ModifySheet creates a UUID filter that is passed through to FilteredList. This way in FilteredList the user only sees the specific item they want to edit.

import SwiftUI
import CoreData

struct ModifySheet: View {

    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var settings: Settings
    @State var idFilter: UUID
    var item: ClothingTemp

 
    var body: some View {
        VStack{
            FilteredList(filter: idFilter, item: item).environment(\.managedObjectContext, viewContext)
        }
    }
}

struct FilteredList: View {
//    @EnvironmentObject var settings: Settings
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    var fetchRequest: FetchRequest<Clothing>
    var items: FetchedResults<Clothing> {
        fetchRequest.wrappedValue
    }
    @State var item: ClothingTemp
    
    var body: some View {
        
        NavigationView{
            VStack {
                PhotoButtonView(imageTemp: $item.image)
            Form {
                Section(header: Text("Approx. cost: \(item.cost, specifier: "%.0f") €")) {
                Slider(value: $item.cost, in: 0...250)
            }
            Section(header: Text("Item Details")) {
                
//                Picker(selection: $item.type, label: Text("Type")) {
//                    ForEach(0 ..< settings.items.count) {
//                        Text(self.settings.items[$0]).tag($0)
//                    }
//                }

                
                Stepper("\(item.wears) wears", value: $item.wears)
            }
        }
                Button(action: {
                    items[0].cost = item.cost
                    items[0].image = item.image
                    items[0].wears = Int16(item.wears)
                    
                    do { try viewContext.save() } catch { print(error) }
                    presentationMode.wrappedValue.dismiss()
                    print("Item updated.")
                    
                }
                )
                {Text("Save")
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .frame(width: 350, height: 60)
                    .background(Color("roseDust"))
                    .cornerRadius(15)
                    .padding(.bottom, 50)
            }
        }
    }
}
    
    init(filter: UUID, item: ClothingTemp) {
        fetchRequest = FetchRequest<Clothing>(entity: Clothing.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id == %@", filter as CVarArg))
        _item = State(initialValue: item)
    }
}
