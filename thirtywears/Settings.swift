//
//  Settings.swift
//  thirtywears
//
//  Created by Penelope Labram on 11/4/21.
//

import Foundation

class Settings: ObservableObject {
    @Published var settingsThreshold: Int
    @Published var items: [String]
    @Published var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        return f
    }()
    @Published var currentBanner: Int = 0
    
    
    init() {
        self.settingsThreshold = 30
        self.items = ["Dress", "Trousers", "Shoes", "Top/Blouse", "Skirt", "Jumper", "Jacket", "Leggings", "T-Shirt"]
    }
    
}

class ImageTemp: ObservableObject {
    var imageTemp: Data
    
    init(){
        self.imageTemp = .init(count:0)
    }
}
