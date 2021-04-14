//
//  OnBoardScreen.swift
//  thirtywears
//
//  Created by Penelope Labram on 6/4/21.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack {
            Spacer()
                Text("30 Wears")
                    .fontWeight(.heavy)
                    .font(.system(size: 50))
                    .frame(width: 300, alignment: .leading)
        
            VStack(alignment: .leading) {
                                NewDetail(image: "leaf.fill", imageColor: Color("myrtleGreen"), title: "The 30 wears rule", description: "Wear clothes frequently to offset carbon omissions.")
                                NewDetail(image: "plus.circle", imageColor: Color("roseDust"), title: "Build your wardrobe", description: "Add pictures of clothes to fill your wardrobe.")
                                NewDetail(image: "list.number", imageColor: Color("cadet"), title: "Build reports", description: "Get statistics on your dashboard and see cost per wear.")
                        }
            Spacer()
            Button("Continue") {
                            self.viewRouter.currentPage = "ContentView"
                        }
                .foregroundColor(.white)
                .font(.headline)
                .frame(width: 350, height: 60)
                .background(Color("roseDust"))
                .cornerRadius(15)
                .padding(.bottom, 50)
        }
        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
        .background(Color("teaGreen"))
        .ignoresSafeArea()

    }
}



struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

