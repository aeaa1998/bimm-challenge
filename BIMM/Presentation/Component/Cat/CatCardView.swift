//
//  CatCardView.swift
//  BIMM
//
//  Created by Augusto Alonso on 7/02/24.
//

import SwiftUI

struct CatCardView: View {
    let cat: Cat
    
    //We will just use the first 4 tags
    private var visibleTags: [String] {
        Array(
            cat.tags
            //We will filter them so long tags are not shown
                .filter { $0.count < 7 }
                .prefix(5)
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CatImageView(cat: cat)
            .frame(height: 150)
            

            VStack(alignment: .leading, spacing: 4) {
                VStack(alignment: .leading) {
                    Text("cat_belongs_to")
                        .font(.caption)
                    Group {
                        if let owner = cat.owner {
                            Text(owner)
                        }else {
                            Text("cat_has_no_owner")
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)

                if visibleTags.count > 0 {
                    tagsView
                }
                //Fill the remaining space
                Spacer()
            }
            .frame(height: 100)
            .padding(12)
        }
        .frame(height: 250)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
    
    private var tagsView: some View {
        FlowLayoutView(items: visibleTags) { tag in
            ChipView(tag)
                .background(Color.appPrimary)
                .font(.system(size: 12).bold())
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
        }
    }
    

}

#Preview {
    VStack {
        HStack {
            GeometryReader { proxy in
                CatCardView(
                    cat: .init(id: "test", tags: ["Tag", "Tag2", "Tag 3", "Tag 4", "Tag 5a"], owner: "a", createdAt: Date(), updatedAt: Date())
                )
                .frame(width: proxy.size.width)
                .clipped()
            }
            
            GeometryReader { proxy in
                CatCardView(
                    cat: .init(
                        id: "iaQ7TgfKYQXIubuW",
                        tags: ["Tag", "Tag2", "Tag 3", "Tag 4", "Tag 5a"],
                        owner: nil,
                        createdAt: Date(),
                        updatedAt: Date()
                    )
                )
                .frame(width: proxy.size.width)
                .clipped()
            }
        }
        
        HStack {
            GeometryReader { proxy in
                CatCardView(
                    cat: .init(id: "test", tags: ["Tag", "Tag2", "Tag 3", "Tag 4", "Tag 5a"], owner: "a", createdAt: Date(), updatedAt: Date())
                )
                .frame(width: proxy.size.width)
                .clipped()
            }
            
            GeometryReader { proxy in
                CatCardView(
                    cat: .init(
                        id: "test",
                        tags: ["Tag", "Tag2", "Tag 3", "Tag 4", "Tag 5a"],
                        owner: nil,
                        createdAt: Date(),
                        updatedAt: Date()
                    )
                )
                .frame(width: proxy.size.width)
                .clipped()
            }
        }
        
        Spacer()
    }
    .padding()
    .background(
        Color.appSecondary,
        ignoresSafeAreaEdges: .all
    )
    .colorScheme(.light)

}



