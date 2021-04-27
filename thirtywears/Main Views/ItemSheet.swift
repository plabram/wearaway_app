//
//  ImageSheet.swift
//  ThreadBare Base
//
//  Created by Penelope Labram on 6/4/21.
//

import SwiftUI
import CoreData

struct ItemSheet: View {
     
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    var settings: Settings
    
    @State var selectedTypeIndex = 0
    @State var wears = 0
    @State var cost: Double = 0
    @State var imageTemp : Data = (UIImage(systemName: "photo")?.jpegData(compressionQuality: 1))!
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                PhotoButtonView(imageTemp: $imageTemp)
                
                Form {
                Section(header: Text("Approx. cost: \(cost, specifier: "%.0f") €")) {
                        Slider(value: $cost, in: 0...250)
                }
                Section(header: Text("Item Details")) {
                    Picker(selection: $selectedTypeIndex, label: Text("Type")) {
                        ForEach(0 ..< settings.items.count) {
                            Text(self.settings.items[$0]).tag($0)
                        }
                    }
                    
                    Stepper("\(wears) wears", value: $wears)
                    
                    
                    HStack(spacing: 0) {
                        Spacer()
                        Text("Old item? ")
                        Button(action: {
                            wears += 10
                        })
                        {
                            Text("Add 10 wears")
                                .foregroundColor(Color("myrtleGreen"))
                                
                        }
                    }
                    .font(.subheadline)

                    
                }
                }
                
                
                Button(action: {
                    guard self.imageTemp != nil else {return}
                    let newItem = Clothing(context: viewContext)
                    newItem.type = self.settings.items[self.selectedTypeIndex]
                    newItem.wears = Int16(self.wears)
                    newItem.cost = self.cost
                    newItem.image = self.imageTemp
                    newItem.id = UUID()
                    do {
                            try viewContext.save()
                            print("Item saved.")
                            presentationMode.wrappedValue.dismiss()
                        } catch {
                            print(error.localizedDescription)
                        }
                }) {
                    Text("Send")
                        .foregroundColor((self.imageTemp != (UIImage(systemName: "photo")?.jpegData(compressionQuality: 1))) ? Color.white : Color.black)
                        .font(.headline)
                        .frame(width: 350, height: 60)
                        .background((self.imageTemp != (UIImage(systemName: "photo")?.jpegData(compressionQuality: 1))) ? Color("roseDust") : Color.gray)
                        .cornerRadius(15)
                        .padding(.bottom, 50)
                    
                }
                
                
                .disabled(imageTemp == (UIImage(systemName: "photo")?.jpegData(compressionQuality: 1))!)
                .navigationTitle("Add Clothes")
            }
        }
    }
}



//struct ItemSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemSheet(settings: Settings).environmentObject(Settings())
//    }
//}
