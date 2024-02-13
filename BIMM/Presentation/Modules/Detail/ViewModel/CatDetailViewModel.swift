//
//  CatDetailViewModel.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import Foundation


final class CatDetailViewModel : ObservableObject {
    @Published private(set) var requestState: RequestState = .none
    @Published private(set) var cat: CatDetail? = nil
    
    
    let catService: CatServiceProtocol
    
    init(catService: CatServiceProtocol = CatService()) {
        self.catService = catService
    }
    
    @MainActor
    func fetchCat(for cat: Cat) async {
        requestState = .loading
        let response = await catService.getCat(for: cat)
        if let data = response.data {
            self.cat = data
            requestState = .success
        }else{
            requestState = .error(response.error)
        }

    }
    
}
