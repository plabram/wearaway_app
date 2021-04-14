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
            Text("""
                This app was inspired by the book "Is it Really Green?", by Georgina Wilson Powell.
                
                In the book, she mentions that wearing an item at least 30 times can work off the carbon emissions created during production.
                
                We're not sure exactly how this number was achieved, but it's definitely true that making sure you get the most of your wardrobe is a great antidote to fast fashion. If you want to set a higher or lower target for yourself, you can change this from your Profile section.
                
                Cost per wear is another well-known way to make sure you get the most from your wardrobe. Are you surprised to see you spend a lot more on some items that others?
                
                Enjoy using the app!
                """)
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
