//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Rodolfo Vasconcelos on 6/11/25.
//

import Foundation
import ThemeKit
import SwiftData

@Model
class DailyScrum: Identifiable {
    var id: UUID
    var title: String
    var lengthInMinutes: Int
    var lengthInMinutesAsDoubles: Double {
        get {
            Double(lengthInMinutes)
        }
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    var theme: Theme
    
    @Relationship(deleteRule: .cascade, inverse: \Attendee.dailyScrum)
    var attendees: [Attendee]
    
    @Relationship(deleteRule: .cascade, inverse: \History.dailyScrum)
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}
