//
//  About.swift
//  thirtywears
//
//  Created by Penelope Labram on 11/4/21.
//

import SwiftUI

struct About: View {
    
    var body: some View {
        NavigationView{
        VStack{
            Text("Cheese slices cheese strings macaroni cheese. Boursin cow roquefort brie halloumi halloumi queso cheesy feet. Feta queso port-salut queso cheeseburger macaroni cheese cheeseburger paneer. Queso swiss.")
                
            Text("Paneer feta mascarpone. Parmesan roquefort hard cheese bavarian bergkase cut the cheese cottage cheese smelly cheese edam. Monterey jack pepper jack caerphilly croque monsieur croque monsieur lancashire brie halloumi. When the cheese comes out everybody's happy st. agur blue cheese stinking bishop danish fontina.")
            Spacer()
    }
        .padding()
        .navigationTitle("Why 30 wears?")
        .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    struct About_Previews: PreviewProvider{
        static var previews: some View {
            About()
        }
    }
}
