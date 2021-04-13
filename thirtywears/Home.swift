//
//  Home.swift
//  thirtywears
//
//  Created by Penelope Labram on 6/4/21.
//

import SwiftUI

struct Home: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var settings: Settings

    @FetchRequest(entity: Clothing.entity(), sortDescriptors: []) var clothing: FetchedResults<Clothing>
    @State var showItemSheet = false
    @State var image: Data = .init(count: 0)
    @State var goToHome = false
    
    var countOfItems: Int {
        getCount(threshold: settings.settingsThreshold)
     }
    
    private var columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                pinnedViews: [.sectionHeaders]) {
                
                Section(header:
                            
                            Text("\(countOfItems)/\(clothing.count) sustainable")
                            .font(.headline)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color(.purple))
                            .foregroundColor(.white)
                            .shadow(color: .gray, radius: 1)
                            
                            ) {
                ForEach(clothing) { item in
                    VStack {
                        Image(uiImage: UIImage(data: item.image ?? self.image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .shadow(color: .gray, radius: 1)
                            .onTapGesture {
                                item.wears += 1
                                do {
                                        try viewContext.save()
                                        print("Taps saved.")
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                            }
                        Text("\(item.type): \(item.wears)")
                            .foregroundColor(item.wears < settings.settingsThreshold ? Color.red : Color.black)
                            .font(.caption)
                        Text("Cost per wear: \(item.costPerWear) €")
                            .foregroundColor(item.cost > 0 ? Color.black : Color.white)
                            .font(.caption)

                    }
                    .padding(6)
                }
            }
            }
        }
                .listStyle(PlainListStyle())
            .navigationTitle("My Wardrobe")
            .navigationBarItems(trailing: Button(action: {
                showItemSheet = true
                }, label: {
                    Image(systemName: "camera.fill")
                        .imageScale(.large)
                        .foregroundColor(.purple)
                }))
            .sheet(isPresented: $showItemSheet) {
                ItemSheet(settings: settings.self)
                }

        }
    }
}
