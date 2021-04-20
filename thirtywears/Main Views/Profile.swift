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
         UITableView.appearance().backgroundColor = UIColor(Color.white)
      }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("About")) {
                NavigationLink(destination: About()) {
                   Text("Why exactly 30 wears?")
                }
                NavigationLink(destination: PrivacyPolicy()) {
                       Text("Privacy Policy")
                    }
            }
                Section(header: Text("Sustainability Limit")) {
                    Stepper("\(settings.settingsThreshold) wears", value: $settings.settingsThreshold)
            }
            }
            .navigationTitle("Profile")
        }
    }
    
    struct Profile_Previews: PreviewProvider{
        static var previews: some View {
            Profile()
                .environmentObject(Settings())
        }
    }
}
