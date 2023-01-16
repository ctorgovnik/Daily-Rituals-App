//
//  ListView.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/21/22.
//

import Foundation
import SwiftUI
import Combine



struct ListView: View {
    
    var date: Date = Date()
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var timeOfDay = Date()
    @State private var timer: Timer?
    
    static let timeInst = Time()
    static let interval = timeInst.interval
    
    
    var body: some View {
        
        List{
            ForEach(listViewModel.itemsForDate(date: date)) { item in
                ListRowView(item: item)
                    .onTapGesture {
                        withAnimation(.linear){
                            listViewModel.updateItem(item: item)
                        }
                    }
            }
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
            /*.onReceive(Timer.publish(every: ListView.interval, tolerance: 0.1, on: RunLoop.main, in: .common)) { _ in
               // Refresh the to-do list at 8:00 am every day
                self.refreshToDoList()
                
            }*/
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
            
        )
                
    }
    /*init() {
            // Calculate the time of day when the list should be refreshed (e.g. 8:00 am)
            let calendar = Calendar.current
            let hour = 8
            let minute = 0
            let currentDate = Date()
            var components = calendar.dateComponents([.year, .month, .day], from: currentDate)
            components.hour = hour
            components.minute = minute
            var triggerTime = calendar.date(from: components)

            // If the trigger time has already passed, add one day to the trigger time
            if triggerTime! < currentDate {
                components.day! += 1
                triggerTime = calendar.date(from: components)
            }

            // Start the timer to refresh the list at the desired time
            timer = Timer.scheduledTimer(withTimeInterval: triggerTime!.timeIntervalSince(currentDate), repeats: false) { _ in
                self.refreshToDoList()
            }
        }*/
    

        func refreshToDoList() {
            // Fetch a new list of to-do items from a remote API or a local database, for example
            let listViewModel = ListViewModel()
            listViewModel.items = [ItemModel(title: "We have refreshed!", isCompleted: false, dueDate: Date())]
        }
    
}

struct ListView_Previews: PreviewProvider{
    static var previews: some View {
        NavigationView{
            ListView(date: Date())
        }
        .environmentObject(ListViewModel())
        
    }
}


