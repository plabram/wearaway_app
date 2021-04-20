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
//                            .onAppear(perform: nextBanner(currentBanner: settings.currentBanner))
                

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

    func nextBanner(currentBanner: Int) -> Int {
        let currentBanner = currentBanner + 1
        if currentBanner >= 3 {
            return {0}()
        }
        else {return currentBanner}
    }
    
}



