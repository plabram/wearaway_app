//
//  Profile.swift
//  thirtywears
//
//  Created by Penelope Labram on 11/4/21.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("About")) {
                NavigationLink(destination: About()) {
                   Text("Why 30 wears?")
                }
            }
                Section(header: Text("Limits")) {
                    Stepper("Sustainability: \(settings.settingsThreshold) wears", value: $settings.settingsThreshold)
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
