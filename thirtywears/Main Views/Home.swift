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
    @State var isEditing = false
    
    
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
                
            BannerView(banner: Banner(id: "0", colour: "myrtleGreen", background: "teaGreen", image: "leaf.fill", text: "Sustainability", description: "\(countOfItems) of \(clothing.count) items"))
                
            ScrollView {

                if clothing.count > 0 {
                    LazyVGrid(
                        columns: columns) {
                    ForEach(clothing.indices, id: \.self) { n in
                        ZStack (alignment: .topTrailing) {
                        TileView(item: clothing[n], image: clothing[n].image)
                    
                        if isEditing == true {
                    Button(action : {
                        deleteClothes(at: [n])
                        print("item deleted")
                    })
                    {
                        ZStack{
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: 40, height: 40)
                                .padding(6)
                                .shadow(radius: 2)
                        Image(systemName: "trash.fill")
                        .foregroundColor(.white)
                        .padding(6)
                        }
                        
                        
                    }
                        
                        }
                        }
                }
//                .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                    }
                }
                else {
                    Text("Your wardrobe is empty.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                
            
            }
            .padding()
            .navigationTitle("My Wardrobe")
                
            }
            .navigationBarItems(leading: Button(action: {
                self.isEditing.toggle()
            }) {
                Text(isEditing ? "Done" : "Remove")
                    .frame(width: 80, height: 40)
            }, trailing: Button(action: {
                showItemSheet = true
                }, label: {
                    ZStack {
//                        Circle()
//                            .foregroundColor(.white)
//                            .frame(width: 50, height: 50)
//                            .shadow(radius: 2)
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color("roseDust"))
                    }
                })
            )
            .sheet(isPresented: $showItemSheet) {
                ItemSheet(settings: settings.self)
                }
            
        }
        
    }
    
    func deleteClothes(at offsets: IndexSet) {
        for offset in offsets {
            let clothes = clothing[offset]
            viewContext.delete(clothes)
        }
        try? viewContext.save()
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(Settings())
    }
}
