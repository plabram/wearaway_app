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
    @State var imageTemp : Data = (UIImage(systemName: "photo.on.rectangle.angled")?.jpegData(compressionQuality: 1))!
    @State var show = false
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 115, height: 115)
                if (self.imageTemp != (UIImage(systemName: "photo.on.rectangle.angled")?.jpegData(compressionQuality: 1))!) {
                    Image(uiImage: UIImage(data: self.imageTemp)!)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(6)
                }
                else {
                    Image(uiImage: UIImage(data: imageTemp)!)
                        .font(.system(size: 55))
                        .foregroundColor(.gray)
                        .frame(width: 100, height: 50)
                        .padding()
                    }
                }

                
                Form {
                    Section(header: Text("Add a photo")) {

                        Button(action: {
                            self.show.toggle()
                        })
                        {Text("Select from Gallery").foregroundColor(Color("myrtleGreen"))}
                        .sheet(isPresented: self.$show, content: {
                            ImagePicker(show: self.$show, image: self.$imageTemp)
                        })
                        
                        Button(action: {
                            self.show.toggle()
                        })
                        {Text("Take new picture").foregroundColor(Color("myrtleGreen"))}
                        .sheet(isPresented: self.$show, content: {
                            ImagePicker(sourceType: .camera, show: self.$show, image: self.$imageTemp)
                        .foregroundColor(Color("myrtleGreen"))
                        })
                    }
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
                        .foregroundColor((self.imageTemp != (UIImage(systemName: "photo.on.rectangle.angled")?.jpegData(compressionQuality: 1))) ? Color.white : Color.black)
                        .font(.headline)
                        .frame(width: 350, height: 60)
                        .background((self.imageTemp != (UIImage(systemName: "photo.on.rectangle.angled")?.jpegData(compressionQuality: 1))) ? Color("roseDust") : Color.gray)
                        .cornerRadius(15)
                        .padding(.bottom, 50)
                }.disabled(imageTemp == (UIImage(systemName: "photo.on.rectangle.angled")?.jpegData(compressionQuality: 1))!)
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
