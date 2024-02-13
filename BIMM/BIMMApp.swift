//
//  BIMMApp.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import SwiftUI

@main struct BIMMApp: App {
    @StateObject  var router : Router = Router<CataasNavigation>()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                CatHomeView()
                    .navigationDestination(for: CataasNavigation.self) { destination in
                        CaatasNavigationResolverView(destination: destination)
                    }
            }
            .environmentObject(router)
        }
    }
}

#Preview {
    NavigationStack {
        CatHomeView()
    }
    
}
