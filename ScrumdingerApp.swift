//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Rodolfo Vasconcelos on 6/9/25.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            ScrumView(scrums: $scrums)
        }
    }
}
