//
//  ModifySheet.swift
//  WearaWay
//
//  Created by Penelope on 22/6/21.
//

import SwiftUI
import CoreData


struct ModifySheet: View {

    @Environment(\.managedObjectContext) private var viewContext
//    @EnvironmentObject var settings: Settings
    @State var idFilter: UUID
    var item: ClothingTemp
    
//    var newCost: Double
//    @State var newWears: Int16
//    var newImage : Data
//    @State var newSelectedTypeIndex: Int16

 
    var body: some View {
        VStack{
            FilteredList(filter: idFilter, item: item).environment(\.managedObjectContext, viewContext)
        }
    }
}

