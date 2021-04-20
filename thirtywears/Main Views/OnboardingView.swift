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
                Text("WearaWay")
                    .fontWeight(.heavy)
                    .font(.system(size: 50))
                    .frame(width: 300, alignment: .leading)
        
            VStack(alignment: .leading) {
                                NewDetail(image: "leaf.fill", imageColor: Color("myrtleGreen"), title: "The 30 wears rule", description: "Wear clothes frequently to offset carbon omissions.")
                                NewDetail(image: "plus.circle", imageColor: Color("roseDust"), title: "Build your wardrobe", description: "Add pictures of clothes to fill your wardrobe.")
                                NewDetail(image: "list.number", imageColor: Color("cadet"), title: "Cost per wear analysis", description: "Get statistics and reports on your wardrobe ROI.")
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
            
            VStack {
                        Text("By tapping Continue, you agree to our ")
                        HStack(spacing: 0) {
                            Link("Terms of Use", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                            Text(" and ")
                            NavigationLink(destination: PrivacyPolicy()) {
                               Text("Privacy Policy")
                            }
//                            }
                            Text(".")
                        }
            }
            .font(.footnote)
            .padding(EdgeInsets(top: 3, leading: 0, bottom: 40, trailing: 0))
            .multilineTextAlignment(.center)

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

