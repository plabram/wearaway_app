//
//  HeadlineTile.swift
//  thirtywears
//
//  Created by Penelope Labram on 14/4/21.
//

import SwiftUI
import CoreData

struct HeadlineTile: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var settings: Settings
    @FetchRequest(entity: Clothing.entity(), sortDescriptors: []) var clothing: FetchedResults<Clothing>
    
    var countOfItems: Int {
        getCount(threshold: settings.settingsThreshold)
     }
    
    var body: some View {
            ZStack {
                Rectangle()
                    .fill(Color("teaGreen"))
                    .cornerRadius(6)
                    .frame(height: UIScreen.main.bounds.width / 4)
                VStack(alignment: .leading) {
                    HStack {
                Image(systemName: "leaf.fill")
                    .foregroundColor(Color("myrtleGreen"))
                Text("Sustainability")
                    .font(.headline)
                    .foregroundColor(Color("myrtleGreen"))
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                Spacer()
                    }
                Spacer()
                    HStack(alignment: .bottom){
                        Text("\(countOfItems) of \(clothing.count) items")
                            .font(.title)
                            .scaledToFill()
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                }
                .padding()
                .frame(height: UIScreen.main.bounds.width / 4)

            }.padding()
    }
}

struct HeadlineTile_Previews: PreviewProvider {
    static var previews: some View {
        HeadlineTile().environmentObject(Settings())
    }
}
