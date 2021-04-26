//
//  Profile.swift
//  thirtywears
//
//  Created by Penelope Labram on 11/4/21.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var settings: Settings
    init() {
         UITableView.appearance().backgroundColor = .clear
      }
    
    var body: some View {
        
        NavigationView{
            Form{
                Section(header: Text("About").foregroundColor(Color("roseDust"))) {
                NavigationLink(destination: About()) {
                   Text("Why exactly 30 times?")
                }
                NavigationLink(destination: PrivacyPolicy()) {
                       Text("Privacy Policy")
                    }
            }
                Section(header: Text("Sustainability Limit").foregroundColor(Color("roseDust"))) {
                    Stepper("\(settings.settingsThreshold) wears", value: $settings.settingsThreshold)
            }
            }
            .navigationTitle("Profile")

        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    struct Profile_Previews: PreviewProvider{
        static var previews: some View {
            Profile()
                .environmentObject(Settings())
        }
    }
}
