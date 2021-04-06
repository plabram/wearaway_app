//
//  ContentView.swift
//  thirtywears
//
//  Created by Penelope Labram on 6/4/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [])

    var clothing: FetchedResults<Clothing>
    @State var showItemSheet = false
    @State var image: Data = .init(count: 0)
    
    var countOfItems: Int {
      getCount()
     }
    
    private var columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

    
//    var sustainabilityCount:Int {
//            get {
//
//                if clothing[0].wears > 4 {
//                return 1
//                }
//                else {
//                    return 0
//                }
//            }
//        }
    
    var body: some View {
        NavigationView {
            ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 10,
                pinnedViews: [.sectionHeaders]) {
                
                Section(header:
                            Text("\(countOfItems)/\(clothing.count) sustainable").font(.headline)) {
                ForEach(clothing) { item in
                    VStack(alignment: .leading) {
                        Image(uiImage: UIImage(data: item.image ?? self.image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .onTapGesture {
                                item.wears += 1
                            }
                        Text("\(item.type): \(item.wears)")
                            .foregroundColor(item.wears < 5 ? Color.red : Color.black)

                    }
                    .padding()
                }
            }
            }
        }
                .listStyle(PlainListStyle())
            .navigationTitle("My Wardrobe")
            .navigationBarItems(trailing: Button(action: {
                showItemSheet = true
                }, label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }))
            .sheet(isPresented: $showItemSheet) {
                    ItemSheet()
                }

        }
    }
}

func getCount() -> Int {
   var countOfItems: Int = 0
   let context = PersistenceController.shared.container.viewContext
   
   let clothingFetchRequest: NSFetchRequest<Clothing> = Clothing.fetchRequest()
   
   clothingFetchRequest.predicate = NSPredicate(format: "wears > %d", 4)
   
   do {
      countOfItems = try context.count(for: clothingFetchRequest)
      print (countOfItems)
   }
   catch {
      print (error)
   }
   return countOfItems
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
