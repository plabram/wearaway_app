//
//  PrivacyPolicy.swift
//  thirtywears
//
//  Created by Penelope Labram on 20/4/21.
//

import SwiftUI

struct PrivacyPolicy: View {

var body: some View {
    NavigationView{
    ScrollView{
        Text("""
            Much as we love data, we know that personal data must be treated with maximum respect. That's why we don't collect anything that could be used to identify you personally.

            The only data we collect is anonymous and is used to make sure the app is offering a fluid service - for example, bug reports.

            Anything that could be used to identify you personally (for example, photos of your clothes) is stored locally on your device so that we don't ever have to touch it.

            We keep all anonymised data between ourselves and Apple and do not share it with third parties aside from this. We don't have adverts on the app.

            We cannot promise that we will never decide to collect personal data. For example, a few people have suggested we build a login screen, which sometimes have a username and password field. If we ever decide to collect personal data, we will ensure to do so in a way which is GDPR compliant - meaning you'll be consulted first and given the opportunity not to share unless it is something completely critical to your use of the app.

            If you have any questions, feel free to contact us at wearaway.the.app@gmail.com.
            """)
        Spacer()
}
    .padding()
    .navigationTitle("Privacy Policy")
    .navigationBarTitleDisplayMode(.inline)
    }
}
}

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicy()
    }
}
