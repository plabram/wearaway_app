//
//  Banners.swift
//  thirtywears
//
//  Created by Penelope Labram on 15/4/21.
//

import Foundation
import SwiftUI

struct Banner {
    var colour: String
    var background: String
    var image: String
    var text: String
    var description: String
}

//var headlineBanner = Banner(colour: "myrtleGreen", background: "teaGreen", image: "leaf.fill", text: "Sustainability", description: "\(countOfItems) of \(clothing.count) items")

var banner0 = Banner(colour: "myrtleGreen", background: "teaGreen", image: "leaf.fill", text: "Title 0", description: "Description of tile contents")

var banner1 = Banner(colour: "roseDust", background: "roseDustOpaque", image: "heart", text: "Title 2", description: "Description of tile contents")

var banner2 = Banner(colour: "englishLavender", background: "englishLavenderOpaque", image: "euro", text: "Title 3", description: "Description of tile contents")


var banners = [Banner]()
var banners0 = banners.append(banner0)
var banners1 = banners.append(banner1)
var banners2 = banners.append(banner2)
