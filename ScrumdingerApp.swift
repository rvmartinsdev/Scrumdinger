//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Rodolfo Vasconcelos on 6/9/25.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumView()
        }
        .modelContainer(for: DailyScrum.self)
    }
}
