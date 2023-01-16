//
//  ListViewModel.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/21/22.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var isListCompleted: Bool = false
    @Published var currentDate: Date = Date()
    @Published var items: [ItemModel] = [] {
        // called any time we change this item array
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    
    init(){
        getItems()
    }
    
    func getItems(){
        
        // tries  to get data from itemsKey, if true it gets this code, if false it returns out of function
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            // decode data back to items
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    // Method to filter the list of to-do list items by the dueDate property
//        func itemsForDate(date: Date) -> [ItemModel] {
//            let calendar = Calendar.current
//            let startOfDate = calendar.startOfDay(for: date)
//            let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
//            //currentDate = date
//            return items.filter { calendar.startOfDay(for: $0.dueDate) >= startOfDate && calendar.startOfDay(for: $0.dueDate) < endOfDate }
//        }
    
    func itemsForDate(date: Date) -> [ItemModel] {
        
        print(date)
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return items.filter {
            let dueMonth = calendar.component(.month, from: $0.dueDate)
            let dueDay = calendar.component(.day, from: $0.dueDate)
            return dueMonth == month && dueDay == day
        }
    }

//    func itemsForDate(date: Date) -> [ItemModel] {
//        let calendar = Calendar.current
//        let startOfDate = calendar.startOfDay(for: date)
//        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)
//        let month = calendar.component(.month, from: date)
//
//        return items.filter {
//            let dueDate = $0.dueDate
//            return (calendar.compare(dueDate, to: startOfDate, toGranularity: .day) == .orderedDescending || calendar.compare(dueDate, to: startOfDate, toGranularity: .day) == .orderedSame)
//                && (calendar.compare(dueDate, to: endOfDate!, toGranularity: .day) == .orderedAscending || calendar.compare(dueDate, to: endOfDate!, toGranularity: .day) == .orderedSame)
//                && calendar.component(.month, from: dueDate) == month
//        }
//    }


    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    func addItem(title: String){
        let newItem = ItemModel(title: title, isCompleted: false, dueDate: currentDate)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        
        // loop through elements in items to find element that equals current element id and store it in index
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
            if (items[index].isCompleted == true){
                let movedObjectIndexes = NSMutableIndexSet()
                movedObjectIndexes.add(index)
                moveItem(from: movedObjectIndexes as IndexSet, to: items.endIndex)
                
            }
        }
        if items.allSatisfy({ $0.isCompleted }) {
            isListCompleted = true
        } else {
            isListCompleted = false
        }
        
    }
    func isEmpty() -> Bool{
        return items.count == 0
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }

}
