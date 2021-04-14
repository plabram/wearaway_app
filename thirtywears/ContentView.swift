//
//  ContentView.swift
//  thirtywears
//
//  Created by Penelope Labram on 6/4/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var settings = Settings()

var body: some View {
    
        ZStack{
            TabView {
                        Home()
                            .tabItem {
                                Label("Wardrobe", systemImage: "house")
                            }
                            .environmentObject(settings)
                

                        Analytics()
                            .tabItem {
                                Label("Reports", systemImage: "sum")
                            }
                            .environmentObject(settings)
                
                
                        Profile()
                            .tabItem {
                                Label("Profile", systemImage: "person")
                            }
                            .environmentObject(settings)
            }.accentColor(Color("roseDust"))
        }
    
}

}
