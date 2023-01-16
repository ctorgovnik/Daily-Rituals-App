//
//  DateHolder.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/23/22.
//

import Foundation

class DateHolder: ObservableObject {
    
    let calendar = Calendar.current
    
    @Published var date = Date() {
        didSet{
            self.selectedDate = self.date
        }
    }
    @Published var selectedDate: Date = Date()
    @Published var dateString: String = ""
    
    func isDateInFuture(_ date: Date) -> Bool {
        return date > Date()
    }

    
}
