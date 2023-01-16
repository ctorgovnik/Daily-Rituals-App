//
//  File.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/23/22.
//

import Foundation

class Time {
    let calendar: Calendar
    var hour: Int
    var minute: Int
    let currentDate: Date
    var components: DateComponents
    let refreshTime: Date
    let interval: TimeInterval

    init() {
        self.calendar = Calendar.current
        self.hour = 19
        self.minute = 35
        self.currentDate = Date()
        self.components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        self.components.hour = hour
        self.components.minute = minute
        self.refreshTime = calendar.date(from: components)!
        self.interval = refreshTime.timeIntervalSince(currentDate)
    }
}
