//
//  CalendarHelper.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/23/22.
//

import Foundation

class CalendarHelper
{
    let dateHolder = DateHolder()
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func monthYearString(_ date: Date) -> String {
        dateFormatter.dateFormat = "LLL yyyy"
        return dateFormatter.string(from: date)
    }
    func plusMonth(_ date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    func minusMonth(_ date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    // returns number of days in any given month
    func daysInMonth(_ date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    // returns day of month for any given date
    func daysOfMonth(_ date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    func firstOfMonth(_ date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    func weekDay(_ date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    func date(count: Int, startingSpaces: Int) -> Date {
        let dateComponents = DateComponents(day: count - startingSpaces)
        return calendar.date(byAdding: dateComponents, to: firstOfMonth(dateHolder.date))!
    }
    
}
