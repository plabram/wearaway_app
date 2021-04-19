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
            VStack{
                TileStruct(banner: Banner(id: "0", colour: "myrtleGreen", background: "teaGreen", image: "leaf.fill", text: "Sustainability", description: "\(countOfItems) of \(clothing.count) items"))
            List {
                if clothing.count > 0 {
                    LazyVGrid(
                        columns: columns) {
                ForEach(clothing) { n in
                    TileView(item: n)
                }
                    }
                }
                else {
                    Text("Your wardrobe is empty.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
            }
//        }
//                .listStyle(PlainListStyle())
                .navigationTitle("My Wardrobe")
                .navigationBarItems(trailing: Button(action: {
                    showItemSheet = true
                    }, label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .shadow(radius: 2)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 45, height: 45)
                                .foregroundColor(Color("roseDust"))
                        }
                    }))
                .sheet(isPresented: $showItemSheet) {
                    ItemSheet(settings: settings.self)
                    }
            }
        }
    }
}
