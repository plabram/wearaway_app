//
//  BarChart.swift
//  WearaWay
//
//  Created by Penelope on 6/7/21.
//
//
//import Foundation
//import SwiftUI
//
//struct BarView: View {
//var value: CGFloat = 0
//var type: String = ""
//var body: some View {
//VStack {
//ZStack(alignment: .bottom) {
//Capsule().frame(width: 30, height: value)
//    .foregroundColor(Color("myrtleGreen"))
//Capsule().frame(width: 30, height: value)
//.foregroundColor(Color("myrtleGreen"))
//Capsule().frame(width: 30, height: value)
//.foregroundColor(Color("myrtleGreen"))
//Capsule().frame(width: 20, height: value)
//.foregroundColor(Color("myrtleGreen"))
//Capsule().frame(width: 20, height: value)
//.foregroundColor(Color("myrtleGreen"))
//  }
//Text(type)
//    .rotationEffect(Angle(degrees: 270))
////    .padding(top: 5)
//    }
//  }
//}
//
//
//struct BarTestView: View {
//    
//    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Clothing.type, ascending: true)]) var clothing: FetchedResults<Clothing>
//    @EnvironmentObject var settings: Settings
//    @State private var pickerSelectedItem = 0
//    @State private var dataPoints: [[CGFloat]] = [
//[150, 120, 150],
//[150, 100, 120],
//[120, 150, 100],
//[120, 100, 150],
//[130, 50, 100]
//]
//var body: some View {
//VStack {
//Picker(selection: $pickerSelectedItem, label: Text("")) {
//    Text("Average wears").tag(0)
//Text("Average cost per Wear").tag(1)
//}.pickerStyle(SegmentedPickerStyle())
//.padding(.horizontal, 24)
//HStack(spacing: 8) {
//    BarView(value: dataPoints[pickerSelectedItem][0], type: "\(settings.types[0])")
//BarView(value: dataPoints[pickerSelectedItem][1], type: "\(settings.types[1])")
//BarView(value: dataPoints[pickerSelectedItem][2], type: "\(settings.types[2])")
//BarView(value: dataPoints[pickerSelectedItem][2], type: "\(settings.types[3])")
//BarView(value: dataPoints[pickerSelectedItem][2], type: "\(settings.types[4])")
//}.padding(.top, 24)
//.animation(.default)
//       }
//  }
//}
//struct BarTestView_Previews: PreviewProvider {
//static var previews: some View {
//    BarTestView().environmentObject(Settings())
//  }
//}
