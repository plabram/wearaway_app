//
//  DrawingPad.swift
//  WearaWay
//
//  Created by Penelope on 20/6/21.
//

//this is the canvas the user can use to draw a picture of their item of clothing

import SwiftUI
import PencilKit

struct drawButton {
    var name: String
    var isDraw: Bool
    var icon: String
    var buttonType: PKInkingTool.InkType
}

struct DrawingPad: View {
    
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State private var color = Color.black
    @State var type: PKInkingTool.InkType = .marker
    @Binding var imageTemp : Data
    @Environment (\.presentationMode) var presentationMode
    
    var buttons: [drawButton] = [
        drawButton(name: "Pencil", isDraw: true, icon: "pencil", buttonType: .pencil),
        drawButton(name: "Pen", isDraw: true, icon: "pencil.tip", buttonType: .pen),
        drawButton(name: "Marker", isDraw: true, icon: "highlighter", buttonType: .marker)
    
    ]
    
    var body: some View {
        NavigationView {
            VStack { 
            DrawingView(canvas: $canvas, isDraw: $isDraw, type: $type, color: $color)
            Spacer()
                
                HStack {
                    Button(action: {
                        isDraw = false
                    }) {
                        Label {
                            Text("Eraser").foregroundColor(isDraw == false ? .black : .blue)
                        } icon: {
                            Image(systemName: "pencil.slash").foregroundColor(isDraw == false ? .black : .blue)
                        }
                    }
                    Spacer()
                    ForEach(buttons, id: \.name){ i in
                        Button(action: {
                            isDraw = i.isDraw
                            type = i.buttonType
                        }) {
                            Label {
                                Text(i.name).foregroundColor((type == i.buttonType && isDraw == true) ? .black : .blue)
                            } icon: {
                                Image(systemName: i.icon).foregroundColor((type == i.buttonType && isDraw == true) ? .black : .blue)
                            }
                        }
                    }
                    Spacer()
                    ColorPicker("", selection: $color, supportsOpacity: false)
                }.padding()
            }
                .navigationTitle("Drawing Pad")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        SaveImage()
                    }, label: {
                        Text("Save")
                    })
    //                .disabled(imageTemp == (UIImage(systemName: "photo")?.jpegData(compressionQuality: 1))!)
                    )
        }
    }
    
    func SaveImage(){
        let drawingTemp = canvas.drawing.image(from:canvas.drawing.bounds, scale: 1)
        imageTemp = drawingTemp.pngData()!
        presentationMode.wrappedValue.dismiss()

    }
}

struct DrawingView: UIViewRepresentable {
    @Binding var canvas : PKCanvasView
    @Binding var isDraw : Bool
    @Binding var type : PKInkingTool.InkType
    @Binding var color : Color
    
    var ink: PKInkingTool{
        PKInkingTool(type, color: UIColor(color))
    }
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView{
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDraw ? ink : eraser
        return canvas
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDraw ? ink : eraser
    }
}


//struct DrawingPad_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawingPad()
//    }
//}
