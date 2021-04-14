//
//  MotherView.swift
//  thirtywears
//
//  Created by Penelope Labram on 14/4/21.
//

import SwiftUI

struct MotherView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
            VStack {
                if viewRouter.currentPage == "OnboardingView" {
                    OnboardingView()
                } else if viewRouter.currentPage == "ContentView" {
                    ContentView()
                }
            }
        }
}
