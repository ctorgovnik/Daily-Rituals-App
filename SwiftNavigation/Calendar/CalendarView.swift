//
//  CalendarView.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/23/22.
//

import SwiftUI


struct CalendarView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    @EnvironmentObject var listViewModel: ListViewModel
    
    
    func dayCompletionStatus(date: Date) -> Bool {
        let itemsForDate = listViewModel.itemsForDate(date: date)
        return itemsForDate.allSatisfy({ $0.isCompleted })
    }

    
    var body: some View {
        VStack(spacing: 1){
            DateScrollerView()
                .environmentObject(dateHolder)
                .padding()
            dayOfWeekStack
            calendarGrid
        }
        
    }
    
    var dayOfWeekStack: some View{
        HStack(spacing: 1){
            Text("Sun").dayOfWeek()
            Text("Mon").dayOfWeek()
            Text("Tue").dayOfWeek()
            Text("Wed").dayOfWeek()
            Text("Thu").dayOfWeek()
            Text("Fri").dayOfWeek()
            Text("Sat").dayOfWeek()
        }
    }
    
    var calendarGrid: some View{
        
        
        
        VStack(spacing: 1){
            // Create an instance of CalendarHelper
            let calendarHelper = CalendarHelper()
            
            let daysInMonth = calendarHelper.daysInMonth(dateHolder.date)
            let firstDayOfMonth = calendarHelper.firstOfMonth(dateHolder.date)
            let startingSpaces = calendarHelper.weekDay(firstDayOfMonth)
            let prevMonth = calendarHelper.minusMonth(dateHolder.date)
            let daysInPrevMonth = calendarHelper.daysInMonth(prevMonth)
            
            ForEach(0..<6){
                row in
                HStack(spacing: 1){
                    ForEach(1..<8){
                        column in
                        let count = column + (row * 7)
                        let selectedDate = calendarHelper.date(count: count, startingSpaces: startingSpaces)
                        /*CalendarCell(count: count, startingSpaces: startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth)
                            .environmentObject(dateHolder)*/
                        /*Button(action: {
                         self.dateHolder.selectedDate = calendarHelper.date(count: count, startingSpaces: startingSpaces)
                         }) {*/
                        ZStack{
//                            Circle()
//                                .frame(width: 25, height: 25)
//                                .background(self.dayCompletionStatus(date: calendarHelper.date(count: count, startingSpaces: startingSpaces)) ? Color.green : Color.red)
//                                .opacity(0.5)
                               
                            NavigationLink(destination: ListView(date: selectedDate).onAppear(){
                                self.listOfTheDay(calendarHelper: calendarHelper, count: count, startingSpaces: startingSpaces)
                            }, label: {
                                CalendarCell(color: (self.dayCompletionStatus(date: calendarHelper.date(count: count, startingSpaces: startingSpaces)) ? Color.green : Color.red) ,count: count, startingSpaces: startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth)
                                    .environmentObject(dateHolder)
                                
                            })
                        }
                        
                        
                        
                        /*CalendarCell(count: count, startingSpaces: startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth)
                         .environmentObject(dateHolder)
                         .onTapGesture {
                                self.listOfTheDay(calendarHelper: calendarHelper, count: count, startingSpaces: startingSpaces)
                            }*/
                            
                        //}
//                            .onTapGesture {
//                                // When the cell is tapped, update the selected date in the dateHolder
//                                self.dateHolder.selectedDate = calendarHelper.date(count: count, startingSpaces: startingSpaces)
//                            }
                    }
                   
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
    
    func listOfTheDay(calendarHelper: CalendarHelper, count: Int, startingSpaces: Int){
        self.dateHolder.selectedDate = calendarHelper.date(count: count, startingSpaces: startingSpaces)
        
    }

}

struct CalendarView_Previews: PreviewProvider {
    
   
    
    static var previews: some View {
        CalendarView()
            .environmentObject(DateHolder())
            
    }
}


extension Text{
    func dayOfWeek() -> some View {
        self.frame(maxWidth: .infinity)
            .padding(.top, 1)
            .lineLimit(1)
    }
}
