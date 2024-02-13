//
//  CatDetailInformationView.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import SwiftUI

struct CatDetailInformationView: View {
    @Environment(\.theme) var theme
    let cat: CatDetail
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("cat_belongs_to")
                .font(.body)
            
            Group {
                if let owner = cat.owner {
                    Text(owner)
                }else{
                    Text("cat_has_no_owner")
                }
            }
            .font(.title2)
            
            ScrollView(.horizontal) {
                HStack() {
                    InfoEntryView(title: "created_at", text: cat.createdAt.formatted(dateStyle: .long, timeStyle: .none))
                    InfoEntryView(title: "updated_at", text: cat.updatedAt.formatted(dateStyle: .long, timeStyle: .none))
                    InfoEntryView(title: "mime_type", text: cat.mimetype)
                }
            }
            .scrollIndicators(.hidden)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("tags").font(.title2) + Text(" (\(cat.tags.count.description))")
                
                if cat.tags.isEmpty {
                    Text("cat_no_tags")
                        .font(.body)
                        .padding(.top)
                }else {
                    FlowLayoutView(items: cat.tags, maxLines: 2) { tag in
                        ChipView(tag.id, size: .medium)
                            .background(theme.palette.primary)
                            .foregroundStyle(.white)
                            .font(.body.bold())
                            .clipShape(theme.shapes.regular)
                    }
                }
            }
        }
    }
    
    
    private func InfoEntryView(title: LocalizedStringKey, text: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
            Text(text)
        }
        .padding()
        .background(theme.palette.primary.opacity(0.4))
        .background(.thickMaterial)
        .clipShape(theme.shapes.small)
        .accessibilityAddTraits([.isSummaryElement])
    }
}

#Preview {
    CatDetailInformationView(cat: .init(id: "test", tags: [], owner: nil, mimetype: "image/png", createdAt: Date(), updatedAt: Date()))
}
