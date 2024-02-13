//
//  Router.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import Foundation
import SwiftUI

//This class supports Destination as a generic that conforms to hashable protocol to support other navigation implementations later
//Imagine we have nested navigations like in a sheet it would become easier to manage with just one router class
final class Router<Destination : Hashable>: ObservableObject {
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
