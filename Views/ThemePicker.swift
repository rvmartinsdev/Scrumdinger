//
//  ThemePickerView.swift
//  Scrumdinger
//
//  Created by Rodolfo Vasconcelos on 6/17/25.
//

import SwiftUI
import ThemeKit

struct ThemePickerView: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

#Preview {
    @Previewable @State var theme = Theme.periwinkle
    ThemePickerView(selection: $theme)
}
