//
//  CalendarCell.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/23/22.
//

import SwiftUI

struct CalendarCell: View {
    
    var color: Color = .white
    
    @EnvironmentObject var dateHolder: DateHolder
    @EnvironmentObject var listViewModel: ListViewModel
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMonth: Int
    
    var body: some View {
        ZStack{
            Circle()
                .fill(dateHolder.isDateInFuture(dateHolder.date) ? Color.white : color)
//                .fill(listViewModel.itemsForDate(date: dateHolder.date).isEmpty ? Color.white : color)
//                .fill(listViewModel.itemsForDate(date: dateHolder.date).isEmpty ? Color.white : color)

                .opacity(0.5)
                //.opacity(0.0)
                .frame(width: 25, height: 25)
            Text(monthStruct().day())
                .foregroundColor(textColor(type: monthStruct().monthType))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
        
    func textColor(type: MonthType) -> Color {
        return type == MonthType.Current ? Color.black : Color.gray
    }
    
    
    func monthStruct() -> MonthStruct {
        let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        if(count <= start){
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: MonthType.Previous, dayInt: day)
        }
        else if (count - start > daysInMonth){
            let day = count - start - daysInMonth
            return MonthStruct(monthType: MonthType.Next, dayInt: day)
        }
        let day = count - start
        return MonthStruct(monthType: MonthType.Current, dayInt: day)
    }
    
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell(count: 1, startingSpaces: 1, daysInMonth: 1, daysInPrevMonth: 1)
    }
}
