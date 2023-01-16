//
//  ItemModel.swift
//  SwiftNavigation
//
//  Created by Cody Torgovnik on 12/21/22.
//

import Foundation

// Immutable struct (use lets instead of var)
struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    let dueDate: Date
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, dueDate: Date){
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, dueDate: dueDate)
    }
}
