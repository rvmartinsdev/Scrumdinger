//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Rodolfo Vasconcelos on 6/15/25.
//

import SwiftUI
import ThemeKit
import SwiftData

struct DetailEditView: View {
    let scrum: DailyScrum
    
    @State private var attendeeName = ""
    @State private var title: String
    @State private var lengthInMinutesAsDouble: Double
    @State private var theme: Theme
    @State private var attendees: [Attendee]

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    private let isCreatingScrum: Bool
    
    init(scrum: DailyScrum?) {
        let scrumToEdit: DailyScrum
        if let scrum {
            scrumToEdit = scrum
            isCreatingScrum = false
        } else {
            scrumToEdit = DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
            isCreatingScrum = true
        }
        
        self.scrum = scrumToEdit
        self.title = scrumToEdit.title
        self.lengthInMinutesAsDouble = scrumToEdit.lengthInMinutesAsDoubles
        self.attendees = scrumToEdit.attendees
        self.theme = scrumToEdit.theme
    }
    
    var body: some View {
        Form {
            Section(header: Text("Meeting info")) {
                TextField("Title", text: $title)
                HStack {
                    Slider(value: $lengthInMinutesAsDouble, in: 1...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(String(format: "%.0f", lengthInMinutesAsDouble)) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePickerView(selection: $theme)
            }
            
            Section(header: Text("Attendees")) {
                ForEach(attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("Name", text: $attendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = Attendee(name: attendeeName)
                            attendees.append(attendee)
                            attendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(attendeeName.isEmpty)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    saveEdits()
                    dismiss()
                }
            }
        }
    }
    
    private func saveEdits() {
        scrum.title = title
        scrum.lengthInMinutesAsDoubles = lengthInMinutesAsDouble
        scrum.attendees = attendees
        scrum.theme = theme
        
        if isCreatingScrum {
            context.insert(scrum)
        }
        
        try? context.save()
    }
}

#Preview(traits: .dailyScrumsSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    DetailEditView(scrum: scrums[0])
}
