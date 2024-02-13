//
//  RouterDestinationResolverView.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import SwiftUI

struct CaatasNavigationResolverView: View {
    let destination : CataasNavigation
    var body: some View {
        switch destination {
        case .home:
            CatHomeView()
        case .detail(let cat):
            CatDetailView(cat: cat)
        }
    }
}

