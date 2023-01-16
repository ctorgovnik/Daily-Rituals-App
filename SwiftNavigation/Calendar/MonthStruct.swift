//
//  MonthStruct.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/23/22.
//

import Foundation

struct MonthStruct{
    var monthType: MonthType
    var dayInt: Int
    func day() -> String {
        return String(dayInt)
    }
}

enum MonthType{
    case Previous
    case Current
    case Next
}
