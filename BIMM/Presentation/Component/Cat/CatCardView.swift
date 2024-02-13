//
//  CatCardView.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import SwiftUI

struct CatCardView: View {
    @Environment(\.theme) var theme
    let cat: Cat
    //Tags to sort to show when we filter
    let filterTags: [String]
    private let size: CGFloat = 100
    //We will just use the first 4 tags
    private var visibleTags: [String] {
        Array(
            cat.tags
            //First filter in alpha order
                .sorted()
                .sorted { lhs, _ in
                    filterTags.contains(lhs)
                }
            //Show 10 as a maximum
                .prefix(10)
        )
    }
    
    init(cat: Cat, filterTags: [String] = []) {
        self.cat = cat
        self.filterTags = filterTags
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CatImageView(
                cat: cat,
                cached: true,
                queryParameters: ["height": "\(size)", "width": "\(size)"]
            )
            .frame(width: size, height: size)
            .background(theme.palette.secondary)
            .clipShape(theme.shapes.regular)
            
            VStack(alignment: .leading) {
                Text(cat.id)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Group {
                    if let owner = cat.owner {
                        Text(owner)
                    }else{
                        Text("cat_has_no_owner")
                    }
                }
                .font(.body)
                
                VStack(alignment: .leading, spacing: 4) {
                    if visibleTags.count > 0 {
                        tagsView
                    }else{
                        Text("cat_no_tags")
                            .font(.caption)
                    }
                    //Fill the remaining space
                    Spacer()
                }
            }
            .padding(.vertical)
        }
        .background(theme.palette.primary.opacity(0.15).accessibilityLabel("Cat card view"))
        .background(.ultraThickMaterial)
        .clipShape(theme.shapes.regular)
        .contentShape(theme.shapes.regular)
        
    }
    
    private var tagsView: some View {
        FlowLayoutView(items: visibleTags) { tag in
            ChipView(tag)
                .background(filterTags.contains(tag) ? theme.palette.primary : theme.palette.primary.opacity(0.4))
                .font(.footnote.bold())
                .foregroundStyle(.white)
                .clipShape(theme.shapes.regular)
                .overlay(theme.shapes.regular.stroke(theme.palette.primary, lineWidth: 2))
                .padding(2)
            
        }
    }
    
    
}

#Preview {
    ScrollView {
        VStack {
            VStack {
                CatCardView(
                    cat: .init(id: "rV1MVEh0Af2Bm4O0", tags: ["Tag", "Tag2", "Tag 3", "Tag 4", "Tag 5a"], owner: "a")
                )
                
                CatCardView(
                    cat: .init(
                        id: "iaQ7TgfKYQXIubuW",
                        tags: ["Tag", "Tag2", "Tag 3", "Tag 4", "Tag 5a"],
                        owner: nil
                    )
                )
                
            }
            
            CatCardView(
                cat: .init(id: "test", tags: ["Tag", "Tag2", "Tag 3", "Tag 4", "Tag 5a"], owner: "a"),
                filterTags: ["Tag"]
            )
            
            CatCardView(
                cat: .init(
                    id: "test",
                    tags: [],
                    owner: nil
                )
            )
        }
        Spacer()
    }
    .padding()
    .background(Color.systemBackground)
}





