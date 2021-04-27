//
//  PhotoButtonView.swift
//  thirtywears
//
//  Created by Penelope Labram on 27/4/21.
//

import SwiftUI

struct PhotoButtonView: View {
    
    @Binding var imageTemp : Data
    @State private var showingActionSheet = false
    @State private var showingType: PhotoSheetType?
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 115, height: 115)
        if (self.imageTemp != (UIImage(systemName: "photo")?.jpegData(compressionQuality: 1))!) {
            Image(uiImage: UIImage(data: self.imageTemp)!)
                .renderingMode(.original)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(6)
        }
        else {
            Image(uiImage: UIImage(data: imageTemp)!)
                .font(.system(size: 55))
                .foregroundColor(Color("myrtleGreen"))
                .frame(width: 100, height: 50)
                .padding()
                .onTapGesture {
                                self.showingActionSheet = true
                            }
                .actionSheet(isPresented: $showingActionSheet) {
                                    ActionSheet(
                                        title: Text("Image selector"),
                                        message: Text("Select an image"),
                                        buttons: [
                                            .default(Text("Select from Gallery")) {
                                                showingType = .gallery /// 3.
                                            },
                                            .default(Text("Take new picture")) {
                                                showingType = .picture /// 3.
                                            },
                                            .cancel()
                                        ]
                                    )
                                }
                .sheet(item: $showingType) { type in
                                    if type == .gallery {
                                        ImagePicker(sourceType: .photoLibrary, image: self.$imageTemp, showingType: $showingType)
                                    } else {
                                        ImagePicker(sourceType: .camera, image: self.$imageTemp, showingType: $showingType)
                                    }
                                }
            }
        }
    }
}

enum PhotoSheetType: Identifiable {
    var id: UUID {
        UUID()
    }
    case gallery
    case picture
}

//struct PhotoButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoButtonView()
//    }
//}
