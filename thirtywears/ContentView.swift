//
//  ContentView.swift
//  thirtywears
//
//  Created by Penelope Labram on 6/4/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(entity: Clothing.entity(), sortDescriptors: [])
//    var clothing: FetchedResults<Clothing>
    var settings = Settings()
    @State var goToHome = false
    
    var body: some View {
        
        ZStack{
            if goToHome{
                TabView {
                            Home()
                                .tabItem {
                                    Label("Menu", systemImage: "house")
                                }
                                .environmentObject(settings)
                    

                            Analytics()
                                .tabItem {
                                    Label("Analytics", systemImage: "sum")
                                }
                                .environmentObject(settings)
                    
                    
                            Profile()
                                .tabItem {
                                    Label("Profile", systemImage: "person")
                                }
                                .environmentObject(settings)
                }
            }
            else {
                OnBoardScreen()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("Success")), perform: {_ in
            withAnimation{self.goToHome = true}
            
        })
        
    }
}


