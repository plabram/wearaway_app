//
//  TileStruct.swift
//  thirtywears
//
//  Created by Penelope Labram on 15/4/21.
//

import SwiftUI
import CoreData

struct TileStruct: View {
    
    var banner: Banner
    
    var body: some View {
            ZStack {
                Rectangle()
                    .fill(Color("\(banner.background)"))
                    .cornerRadius(6)
                    .frame(height: UIScreen.main.bounds.width / 4)
                VStack(alignment: .leading) {
                    HStack {
                Image(systemName: "\(banner.image)")
                    .foregroundColor(Color("\(banner.colour)"))
                Text("\(banner.text)")
                    .font(.headline)
                    .foregroundColor(Color("\(banner.colour)"))
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                Spacer()
                    }
                Spacer()
                    HStack(alignment: .bottom){
                        Text("\(banner.description)")
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

//struct TileStruct_Previews: PreviewProvider {
//    static var previews: some View {
//        TileStruct(banner: Banner())
//    }
//}
