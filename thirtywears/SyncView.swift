//
//  SyncView.swift
//  thirtywears
//
//  Created by Penelope Labram on 12/4/21.
//

import SwiftUI

struct SyncView<Content: View>: View {

    @Binding var selection: Int

    var tag: Int

    var content: () -> Content

    @ViewBuilder
    var body: some View {
        if selection == tag {
            content()
        } else {
            Spacer()
        }
    }
}
