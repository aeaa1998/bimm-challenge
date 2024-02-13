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
    
    var optionsToShow: [String] {
        options
            .filter { tag in
                search.isEmpty || tag.lowercased().contains(search.lowercased())
            }
            .sorted()
            .sorted(by: { lhs, rhs in
                selected.contains(lhs)
            })
    }
    
    func apply(){
        selected = holder
    }
    
    func reset(){
        holder = selected
    }
    
}
