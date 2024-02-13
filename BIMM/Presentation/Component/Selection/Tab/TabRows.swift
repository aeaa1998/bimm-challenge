//
//  TabsRow.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import SwiftUI

struct TabRows<Content: View, TabItem : Identifiable> : View {
    
    @Binding var selected: TabItem
    let items: [TabItem]
    let content: (TabItem) -> Content
    
    init(selected: Binding<TabItem>, items: [TabItem], content: @escaping (TabItem) -> Content) {
        self.content = content
        self._selected = selected
        self.items = items
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(items) { item in
                Button(action: {
                    selected = item
                }) {
                    content(item)
                }
                .tag(item.id)
            }
        }
    }
}

extension TabRows where Content == TabRow {
    init(selected: Binding<TabItem>, items: [TabItem], text: @escaping (TabItem) -> String){
        self.init(selected: selected, items: items, content: { item in
            TabRow(text(item), selected: selected.id == item.id)
            
        })
    }
    
    init(selected: Binding<TabItem>, items: [TabItem], text: @escaping (TabItem) -> LocalizedStringKey){
        self.init(selected: selected, items: items, content: { item in
            TabRow(text(item), selected: selected.id == item.id)
            
        })
    }
}


extension TabRows where Content == TabRow, TabItem.ID == String {
    init(selected: Binding<TabItem>, items: [TabItem], localized: Bool){
        self.init(selected: selected, items: items, content: { item in
            if localized {
                TabRow(item.id.localized(), selected: selected.id == item.id)
            } else {
                TabRow(item.id, selected: selected.id == item.id)
            }
        })
    }
}

private struct Preview : View {
    @State var selected: String = "test"
    var body: some View { 
        TabRows(
            selected: $selected,
            items: ["test", "test2"],
            text: { $0 }
        )
    }
}

#Preview {
    Preview()
}
