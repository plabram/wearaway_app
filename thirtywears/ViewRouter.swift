//
//  ViewRouter.swift
//  thirtywears
//
//  Created by Penelope Labram on 14/4/21.
//

import Foundation

class ViewRouter: ObservableObject {

    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = "OnboardingView"
        } else {
            currentPage = "ContentView"
        }
    }
    
    @Published var currentPage: String
    
}
