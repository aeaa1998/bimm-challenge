//
//  CatHomeViewModel.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import Foundation
import Combine

final class CatHomeViewModel : ObservableObject {
    
    private let catService : CatServiceProtocol
    @Published private(set) var requestState: RequestState = .none
    @Published private(set) var tagsRequestState: RequestState = .none
    @Published private(set) var cats: [Cat] = []
    @Published private(set) var selectedFilters: [String] = []
    
    let catHomeFilterState: CatHomeFilterState = CatHomeFilterState()
    private var cancellables: [AnyCancellable] = []
    
    
    init(catService: CatServiceProtocol = CatService()) {
        self.catService = catService
        //In each one of the changes we have of the selected tags
        catHomeFilterState.$selected
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tags in
                self?.selectedFilters = tags
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func fetchTags() async {
        tagsRequestState = .loading
        let response = await catService.getTags()
        if let data = response.data {
            catHomeFilterState.options = Set(data.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
            tagsRequestState = .success
        }else {
            tagsRequestState = .error(response.error)
        }
    }
    
    @MainActor
    func fetchCats() async {
        //Just fetch first time
        if !cats.isEmpty {
            return
        }
        requestState = .loading
        let response = await catService.getCats()
        if let data = response.data {
            requestState = .success
            cats = data
        }else {
            requestState = .error(response.error)
        }
    }
    
    
}
