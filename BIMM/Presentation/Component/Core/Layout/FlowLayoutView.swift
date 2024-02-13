//
//  FlowLayoutModifier.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import SwiftUI

struct FlowLayoutView<Item: Equatable & Hashable, Content: View>: View {
    
    let items: [Item]
    let maxLines: Int?
    let spacingX: Double
    let spacingY: Double
    let content: (Item) -> Content
    
    init(items: [Item], maxLines: Int? = nil, spacingX: Double = 4, spacingY: Double = 4, content: @escaping (Item) -> Content) {
        self.items = items
        self.content = content
        self.maxLines = maxLines
        self.spacingX = spacingX
        self.spacingY = spacingY
    }
    
    @State private var finalHeight: CGFloat = CGFloat.zero
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return GeometryReader { geo in
            ZStack(alignment: .topLeading, content: {
                ForEach(items, id: \.self){ item in
                    content(item)
                        .alignmentGuide(.leading) { dimension in  //update leading width for available width
                            if (abs(width - dimension.width) > geo.size.width) {
                                width = 0
                                height -= dimension.height + spacingY
                            }
                            
                            let result = width
                            if item == items.last! {
                                width = 0
                            } else {
                                //Add a little spacing
                                width -= dimension.width + spacingX
                            }
                            return result
                        }
                        .alignmentGuide(.top) { dimension in //update chips height origin wrt past chip
                            let result = height
                            
                            if item == items.last! {
                                height = 0
                            }
                            return result
                        }
                }
            })
            .background(GeometryReader {gp -> Color in
                DispatchQueue.main.async {
                    finalHeight = gp.size.height
                }
                
                return Color.clear
            })
            
        }
        .frame(height: finalHeight)
        .clipped()
    }
    
    fileprivate struct Holder : Hashable {
        let item: Item
        let line: Int
        let height: CGFloat
    }
}

#Preview {
    FlowLayoutView(
    items: ["Test1", "Test2"]
    ){
        Text($0)
            .padding(.vertical, 2)
            .padding(.horizontal, 6)
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .font(.system(size: 11).bold())
            .foregroundColor(.white)
    }
}
