//
//  CatHomeFilterState.swift
//  BIMM
//
//  Created by Augusto Alonso on 11/02/24.
//

import Foundation
import Combine

class CatHomeFilterState : ObservableObject {
    //It is a set to ensure no duplicates are a thing
    @Published var options: Set<String> = Set()
    @Published var selected: [String] = []
    @Published var holder: [String] = []
    @Published var search: String = ""
    @Published var showAllOptions: Bool = false
    
    var optionsToShow: [String] {
        let options = options
            .sorted()
            .sorted(by: { lhs, rhs in
                selected.contains(lhs)
            })
            
        //We only apply the filter when the whole list is displayed
        if showAllOptions {
            return options
                .filter { tag in
                    search.isEmpty ||  tag.lowercased().contains(search.lowercased())
                }
        }else{
            return Array(options.prefix(14))
        }
    }
    
    func clean(){
        search = ""
        showAllOptions = false
    }
    
    func apply(){
        selected = holder
    }
    
    func reset(){
        holder = selected
    }
    
    func toggleSelecteTag(for tag: String) {
        if holder.contains(tag) {
            holder = holder.filter { $0 != tag }
        }else{
            holder.append(tag)
        }
    }
    
}
