//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by Rodolfo Vasconcelos on 6/24/25.
//

import SwiftUI

struct NewScrumSheet: View {

    var body: some View {
        NavigationStack {
            DetailEditView(scrum: nil)
        }
    }
}

#Preview {
    NewScrumSheet()
}
