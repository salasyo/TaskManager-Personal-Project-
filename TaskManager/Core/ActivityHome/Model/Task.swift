//
//  Task.swift
//  KavSoft
//
//  Created by Obi on 9/19/23.
//

import SwiftUI
import SwiftData

@Model
class Activity: Identifiable {
    var id: UUID
    var taskTitle: String
    var creationDate: Date
    var isCompleted: Bool 
    var tint: String
    
    init(id: UUID = .init(), taskTitle: String, creationDate: Date = .init(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.taskTitle = taskTitle
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
    }
    
    var tintColor: Color {
        switch tint {
        case "TaskColor 1": return Color(.taskColor1)
        case "TaskColor 2": return Color(.taskColor2)
        case "TaskColor 3": return Color(.taskColor3)
        case "TaskColor 4": return Color(.taskColor4)
        case "TaskColor 5": return Color(.taskColor5)
        default: return .black
        }
    }
}

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
