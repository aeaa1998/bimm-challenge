//
//  CatHomeFilterView.swift
//  BIMM
//
//  Created by Augusto Alonso on 10/02/24.
//

import SwiftUI

struct CatHomeFilterBottomSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.theme) var theme
    
    //The tags to search
    @ObservedObject var state: CatHomeFilterState
    
    var body: some View {
        
        VStack {
            header
            Divider()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    tagsHeading
                    
                    //If we are showing all of the options we will allow to filter
                    if state.showAllOptions {
                        TextField("search_tags_placeholder", text: $state.search)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    if state.optionsToShow.isEmpty {
                        emptyView
                    }else{
                        //When showing all of the options we will use a list and a lazy vstack for better performance
                        if state.showAllOptions {
                            LazyVStack(spacing: 0) {
                                ForEach(state.optionsToShow) { tag in
                                    VStack(spacing: 0) {
                                        CatHomeFilterRowView(
                                            tag: tag,
                                            selected: state.holder.contains(tag)
                                        )
                                        .accessibilityLabel(for: tag)
                                        .onTapGesture {
                                            state.toggleSelecteTag(for: tag)
                                        }
                                        
                                        if tag != state.optionsToShow.last {
                                            Divider()
                                        }
                                    }
                                }
                            }
                        }else{
                            //Only show a subset of tags for convinience
                            FlowLayoutView(items: state.optionsToShow, spacingX: 8) { tag in
                                CatHomeFilterChipView(
                                    tag: tag,
                                    selected: state.holder.contains(tag)
                                )
                                .accessibilityLabel(for: tag)
                                .onTapGesture {
                                    state.toggleSelecteTag(for: tag)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .scrollDismissesKeyboard(.interactively)
            
            Spacer()
        }
        .addKeyboardDismissAction()
        .ignoresSafeArea(.all, edges: .bottom)
        .padding([.top, .horizontal])
        .background(theme.backgrounds.sheet)
        .presentationDetents([.fraction(0.7), .large])
        .presentationContentInteraction(.scrolls)
        .interactiveDismissDisabled()
        .onAppear {
            //Clean each time the search value
            state.clean()
        }
        //We won't allow to be dismissable by dragging
    }
    
    private var header: some View {
        HStack(spacing: 16) {
            Button(action: {
                state.reset()
            }) {
                Text("reset")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("filters")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Button(action: {
                dismiss()
                state.apply()
            }) {
                Text("done")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private var tagsHeading: some View {
        HStack {
            Text("tags")
                .font(.title3.bold())
            
            Spacer()
            
            Button(action: {
                state.showAllOptions.toggle()
            }){
                Text(state.showAllOptions ? "see_less".localized() : "see_all".localized())
            }
        }
    }
    
    private var emptyView: some View {
        Text("no_results")
            .font(.body)
    }
    
}

//Exntesion function to implement un an easier way accessibikkity for tags
fileprivate extension View {
    func accessibilityLabel(for tag: String) -> some View {
        self
            .accessibilityHint(Text("filter_button_description") + Text(" \(tag)"))
    }
}

fileprivate struct Preview : View {
    @StateObject var state = CatHomeFilterState()
    @State var visible = true
    
    var body: some View {
        VStack{
            Button(action: {
                visible = true
            }, label: {
                Text("Touch me")
            })
        }
        .sheet(isPresented: $visible) {
            CatHomeFilterBottomSheetView(state: state)
                
        }
        .onAppear {
            state.options = Set((1...100).map { "Tag \($0)" })
        }
    }
}

#Preview {
    Preview()
        .preferredColorScheme(.dark)
}
