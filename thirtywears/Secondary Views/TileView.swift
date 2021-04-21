//
//  TileView.swift
//  thirtywears
//
//  Created by Penelope Labram on 14/4/21.
//

import SwiftUI
import CoreData

struct TileView: View {
    
    @ObservedObject var item: Clothing
    @EnvironmentObject var settings: Settings
    @Environment(\.managedObjectContext) private var viewContext
    @State var image: Data = .init(count: 0)

    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: item.image ?? self.image)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .border(Color("lightGrey"))
                .cornerRadius(6)
                .onTapGesture {
                    item.wears += 1
                    do {
                            try viewContext.save()
                            print("Taps saved.")
                        } catch {
                            print(error.localizedDescription)
                        }
                }
            HStack{
                VStack(alignment: .leading) {
            Text("\(item.type): \(item.wears) wears")
                .font(.headline)
                .scaledToFill()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                    Text("\(item.costPerWear)")
                .font(.subheadline)
                .scaledToFill()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .leading) {
                if (item.wears >= settings.settingsThreshold) {
                    Image(systemName: "leaf.fill")
                    .foregroundColor(Color("myrtleGreen"))
                }
                else {
                    Image(systemName: "leaf")
                        .foregroundColor(Color("teaGreen"))
                }
                
                }
            }

        }
    }
    
}


struct TileView_Previews: PreviewProvider {
    static let viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let item = Clothing(context: viewContext)
        item.type = "Dress"
        item.wears = 4
        item.cost = 3
        item.image = (UIImage(named: "clothes")?.pngData()!)!

        return NavigationView {
            TileView(item: item).environmentObject(Settings())
        }
    }
}
