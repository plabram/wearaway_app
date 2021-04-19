//
//  Banners.swift
//  thirtywears
//
//  Created by Penelope Labram on 15/4/21.
//

import Foundation
import SwiftUI

struct Banner: Codable, Identifiable {
    var id: String
    var colour: String
    var background: String
    var image: String
    var text: String
    var description: String
}
