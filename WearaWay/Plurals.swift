//
//  Plurals.swift
//  WearaWay
//
//  Created by Penelope on 20/6/21.
//

import Foundation

extension String {
func pluralNames() -> String {
    if (self.suffix(2) == "ss") {
        return self + "es"
    }
    else if (self.suffix(1) == "s") {
        return self
    }
    else {
        return self + "s"
    }
}
}

func pluralise(stringBase : String, items: Int) -> String {
    if items == 1 {
        return stringBase
    }
    else {
        let newString = stringBase + "s"
        return newString
    }
}
