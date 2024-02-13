//
//  TabsRow.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import SwiftUI

struct TabsRow<Content: View, TabItem : Identifiable> : View {
    
    @Binding var selected: TabItem
    let items: [TabItem]
    let content: (TabItem) -> Content
    
    init(selected: Binding<TabItem>, items: [TabItem], content: @escaping (TabItem) -> Content) {
        self.content = content
        self._selected = selected
        self.items = items
    }
    
    var body: some View {
        HStack {
            ForEach(items) { item in
                content(item)
                    .onTapGesture {
                        selected = item
                    }
            }
        }
    }
}

extension TabsRow where Content == TabRow {
    init(selected: Binding<TabItem>, items: [TabItem], text: @escaping (TabItem) -> String){
        self.content = { item in
            TabRow(text(item), selected: selected.id == item.id)
        }
        self._selected = selected
        self.items = items
    }
}

private struct Preview : View {
    @State var selected: String = "test"
    var body: some View { 
        TabsRow(
            selected: $selected,
            items: ["test", "test2"],
            text: { $0 }
        )
    }
}

#Preview {
    Preview()
}
